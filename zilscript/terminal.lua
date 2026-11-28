local M = {}

local esc = "\27["

local function escape_pattern(text)
  return (text:gsub("([^%w])", "%%%1"))
end

function M.bold(text)
  return esc .. "1m" .. text .. esc .. "0m"
end

function M.bold_words(text, words)
  if type(words) ~= "table" then
    return text
  end

  for _, word in ipairs(words) do
    local pattern = escape_pattern(word)
    local capitalized = word:sub(1, 1):upper() .. word:sub(2)
    local capitalized_pattern = escape_pattern(capitalized)

    text = text:gsub("(%f[%a]" .. pattern .. "%f[%A])", M.bold)
    text = text:gsub(
      "(%f[%a]" .. capitalized_pattern .. "%f[%A])",
      M.bold
    )
  end

  return text
end

-- Book text already knows which phrases are genuine affordances. Never
-- guess from the global dictionary (German "führt" is not the "f" exit).
function M.bold_links(text)
  return (text:gsub("%[%[(.-)%]%]", function(link)
    return M.bold(link:match("^(.-)%->") or link)
  end))
end

local Terminal = {}
Terminal.__index = Terminal

function Terminal:write(text)
  self.stdout:write(text)
end

function Terminal:flush()
  self.stdout:flush()
end

function Terminal:enter_raw()
  local handle = self.popen("stty -g 2>/dev/null")
  local settings = handle and handle:read("l")
  if handle then handle:close() end
  if settings and settings:match("^[%w:;=+_%-]+$") then
    self.settings = settings
  end
  -- A timed zero-byte read makes Lua's stream report EOF on an idle TTY.
  self.execute("stty -icanon -echo -isig min 1 time 0 2>/dev/null")
end

function Terminal:leave_raw()
  if self.settings then
    self.execute("stty '" .. self.settings .. "' 2>/dev/null")
    self.settings = nil
  else
    self.execute("stty icanon echo isig 2>/dev/null")
  end
end

function Terminal:width()
  local handle = self.popen("tput cols 2>/dev/null || echo 80")
  local width = handle and handle:read("*n") or 80
  if handle then
    handle:close()
  end
  return width or 80
end

function Terminal:read_key()
  local char = self.pending_byte or self.stdin:read(1)
  self.pending_byte = nil
  if not char then
    return {kind = "eof"}
  end

  if char == "\27" then
    local prefix = self.stdin:read(1)
    if prefix == "[" then
      local code = self.stdin:read(1)
      if code == "A" then
        return {kind = "up"}
      elseif code == "B" then
        return {kind = "down"}
      end
    else
      self.pending_byte = prefix
    end
    return {kind = "escape"}
  elseif char == "\21" then
    -- Ctrl-U clears the field immediately even on terminals that send
    -- Escape as the prefix of a cursor-key sequence.
    return {kind = "escape"}
  elseif char == "\r" or char == "\n" then
    return {kind = "enter"}
  elseif char == "\127" or char == "\8" then
    return {kind = "backspace"}
  elseif char == "\3" then
    return {kind = "interrupt"}
  elseif char:match("^[%w%p%s]$") then
    return {kind = "text", text = char}
  end

  local lead = char:byte()
  local size = lead >= 0xC2 and lead <= 0xDF and 2
    or lead >= 0xE0 and lead <= 0xEF and 3
    or lead >= 0xF0 and lead <= 0xF4 and 4
  if size then
    local sequence = char
    for _ = 2, size do
      local byte = self.stdin:read(1)
      if not byte or not byte:match("^[\128-\191]$") then
        self.pending_byte = byte
        return {kind = "unknown"}
      end
      sequence = sequence .. byte
    end
    if utf8.len(sequence) then return {kind = "text", text = sequence} end
  end
  return {kind = "unknown"}
end

function M.new(dependencies)
  dependencies = dependencies or {}
  return setmetatable({
    stdin = dependencies.stdin or io.stdin,
    stdout = dependencies.stdout or io.stdout,
    execute = dependencies.execute or os.execute,
    popen = dependencies.popen or io.popen,
  }, Terminal)
end

M.default = M.new()

return M
