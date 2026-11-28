-- An optional pre-game contract for a fresh VM. No story command is
-- synthesized, and the book's GO isn't entered until a selection is accepted.
local Setup = {}

local function text(value)
  return type(value) == "string" and utf8.len(value) and value:find("%S")
end

function Setup.profiles(env)
  if type(env.RPG_PRESET_COUNT) ~= "function" then return {} end
  local count = env.RPG_PRESET_COUNT()
  if count == 0 then return {} end
  assert(type(count) == "number" and count >= 1 and count <= 32 and count % 1 == 0, "Invalid RPG preset count")
  local list, seen = {}, {}
  local preset, row = env.SETUP_PRESET, env.SHEET_ROW
  env.SETUP_PRESET = function(id, title, summary)
    assert(type(id) == "string" and id:match("^[a-z0-9][a-z0-9-]*$") and #id <= 64 and not seen[id], "Invalid RPG preset ID")
    assert(text(title) and text(summary), "Invalid RPG preset text")
    seen[id] = true
    list[#list+1] = { id = id, title = title, summary = summary, rows = {} }
  end
  env.SHEET_ROW = function(label, value, maximum, group, rankLabel)
    local rows = assert(list[#list], "RPG preset row without a preset").rows
    assert(text(label) and type(value) == "number", "Invalid RPG preset value")
    rows[#rows+1] = { label = label, value = value,
      maximum = type(maximum) == "number" and maximum > 0 and maximum or nil,
      group = text(group) and group or nil, rankLabel = text(rankLabel) and rankLabel or nil }
  end
  local ok, failure = pcall(env.RPG_EXPORT_PRESETS)
  env.SETUP_PRESET, env.SHEET_ROW = preset, row
  if not ok then error(failure, 0) end
  assert(#list == count, "Incomplete RPG preset catalog")
  return list
end

function Setup.normalizeName(value)
  if value == nil then return "" end
  if type(value) ~= "string" or #value > 128 or value:find("[%z%c]") or value:find("[[", 1, true) or value:find("]]", 1, true) then return nil end
  value = value:match("^%s*(.-)%s*$")
  local length = utf8.len(value)
  if not length or length > 32 then return nil end
  return value
end

function Setup.select(env, selection)
  if type(selection) ~= "table" then return false, "invalid_preset" end
  local name = Setup.normalizeName(selection.name)
  if not name then return false, "invalid_name" end
  for index, profile in ipairs(Setup.profiles(env)) do
    if profile.id == selection.id and env.ZIL_TRUE(env.RPG_SELECT_PRESET(index, name ~= "" and name or nil)) then
      -- Restarting this new VM goes back to the confirmed setup, not to
      -- the parser-only profile prompt hidden by the graphical client.
      env.CAPTURE_RESTART_STATE()
      return true
    end
  end
  return false, "invalid_preset"
end

return Setup
