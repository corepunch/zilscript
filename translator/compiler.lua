local utils = require "translator.utils"
local compiler = {}

local u_endings = {
  ["011"] = "ен",    -- I do
  ["012"] = "ен",    -- you do (sg)
  ["03"]  = "но",    -- he/she/it does
  ["031"] = "ен",    -- he/she/it does
  ["032"] = "на",    -- he/she/it does
  ["11"]  = "ны",    -- we do
  ["12"]  = "ны",    -- you do (pl)
  ["13"]  = "ны",    -- they do
}

local function verb(primary, transform, secondary)
  local d = utils.decode(primary, true)
  if (primary:sub(1,1) == 'V' or primary:sub(1,1) == 'Z') and base[d] then
    local conf = base[d]
    local index = conf:byte(4)&~0x80
    d = paradigms.verb(primary, index, transform or 3)
  end
  -- if primary:sub(1,1) == 'U' then d = suffix(d, "ен", u_endings[transform or "031"]) end
  if secondary then
    local conf = base[utils.decode(secondary, true)]
    secondary = utils.decode(conf and conf:sub(6) or secondary)
    return d.." "..secondary
  else return d end
end

local function noun(s, ...)
  local t = {}
  local gender = 3
  if base[utils.decode(s, true)] then 
    gender = base[utils.decode(s, true)]:byte(3)&3 
  end
  for _, a in ipairs {...} do 
    local _a = utils.extract(a)
    local d = utils.decode(_a:sub(1, #_a-2), true)
    if base[d] then
      local code = (base[d]:byte(2)==0x80 and base[d]:byte(3) or base[d]:byte(4))&~0x80
      print(utils.decode(s, true), gender, code)
      table.insert(t, paradigms.adjective(a, code, gender, 1))
    else
      table.insert(t, utils.decode(a, true)..'*')
    end
  end
  table.insert(t, utils.decode(s, true))
  return table.concat(t, " ")
end

local function read_transform(noun)
  local num1, num2 = noun:match("R(%d)(%d)")
  local a, b = num1 or 0, num2 or 3
  return a * 3 + b
end


function compiler.compile(s)
  for _, w in ipairs(s) do
    print(utils.decode(w, true))
  end
end
  -- print(
  --   table.concat({
  --     noun(s.subject.noun, table.unpack(s.subject)),
  --     verb(s.verb.verb, read_transform(s.subject.noun), s.verb.secondary),
  --     noun(s.object.noun, table.unpack(s.object))}, 
  --   " "))

return compiler