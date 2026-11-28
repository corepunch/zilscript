-- PRE-TAKE validates an explicitly named source, then clears PRSI so the
-- same take path as a bare command can run. A scenery TAKE handler on the
-- source must never intercept the child's command after that decision.
local Walk = require("tests.link_walk")

local function try(module, roomName, objectName, sourceName, command)
  local walk = Walk.new(module)
  local e = walk.env
  local room, child, source = e[roomName], e[objectName], e[sourceName]
  e.HERE = room
  e.MOVE(e.WINNER, room)
  e.MOVE(child, source)
  e.FSET(source, e.OPENBIT)
  local attempted = 0
  e.PUTP(source, e.PQACTION, function()
    if e.PRSA == e.VQTAKE then
      attempted = attempted + 1
      e.TELL("The fixed container itself will not move.", e.CR)
      return true
    end
  end)
  local output = walk.game:resume(command)
  assert(attempted == 0 and e.LOC(child) == e.WINNER, module .. ": " .. tostring(output))
end

try("books.en.bell-grew-leaves.bell-grew-leaves", "COURT", "WICK", "BELL", "take wick from bell")
try("books.de.borrowed-tomorrows.borrowed-tomorrows", "TERRACE", "LEAF", "FRAME", "nimm blatt aus rahmen")
print("ok - both language loops dispatch a take to the child, not the validated source")
