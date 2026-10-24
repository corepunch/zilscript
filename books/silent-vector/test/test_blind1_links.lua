-- Focused RED/GREEN parser regressions from independent blind round 1.
local runtime = require("zilscript.runtime")
local env = runtime.create_game_env()
assert(runtime.init(env, true))
env.require("zilscript")
assert(runtime.load_modules(env, { "books.silent-vector.silent-vector" }, { silent = true }))
local game = runtime.create_game(env, true)
game:start()
local failures = {}
local function check(ok, message)
	if not ok then table.insert(failures, message) end
end
local function enter(room)
	env.HERE = room
	env.MOVE(env.WINNER, room)
end
local function occurrences(text, needle)
	local count, cursor = 0, 1
	while true do
		local at = text:find(needle, cursor, true)
		if not at then return count end
		count, cursor = count + 1, at + #needle
	end
end
for _, object in ipairs({ env.WRENCH, env.SHEARS, env.SPOOL }) do env.MOVE(object, env.WINNER) end
enter(env.COOLANT)
local output = game:resume("turn pump with shears")
check(output:find("calibrated torque wrench", 1, true) and not env.COOLING,
	"Turn with wrong tool must explain the torque fitting and leave cooling unrestored")
output = game:resume("turn pump with wrench")
check(env.COOLING and output:find("calibrated click", 1, true),
	"Natural TURN PUMP WITH WRENCH must repair the real fitting")
enter(env.RELAY)
output = game:resume("fit bus to spool")
check(env.TERMINATED and env.LOC(env.SPOOL) == env.BUS,
	"Room-first FIT BUS TO SPOOL must fit the actual held spool")
enter(env.CORE)
output = game:resume("preserve console")
check(occurrences(output, "No commitment is made.") == 1 and not env.RESOLVED,
	"A premature Preserve must print exactly one refusal and not end the story")
output = game:resume("erase console")
check(occurrences(output, "No commitment is made.") == 1 and not env.RESOLVED,
	"A premature Erase must print exactly one refusal and not end the story")
env.PROOF = true
enter(env.QUARANTINE)
output = game:resume("ask senn about daughter")
check(output:find("would have been thirty-one", 1, true), "Early testimony retains the missing-years clue")
enter(env.RELAY)
game:resume("cut bus with shears")
enter(env.QUARANTINE)
output = game:resume("look")
check(output:find("daughter", 1, true) and output:find("again", 1, true),
	"Isolation observably invites the previously exhausted daughter topic")
output = game:resume("ask senn about daughter")
check(env.SENN_DISCLOSED and output:find("Lena died at nine", 1, true), "Prompted testimony discloses the training source")
output = game:resume("examine senn")
check(output:find("hands closed", 1, true), "Description reflects Senn's changed physical state")
env.MOVE(env.STRIP, env.WINNER)
env.MOVE(env.WAFER, env.WINNER)
env.ORIGIN = false
output = game:resume("listen to wafer")
check(output:find("makes no sound", 1, true) and not env.ORIGIN,
	"Listening cannot read the engraved provenance index")
env.CONSENT = true
enter(env.CLINIC)
output = game:resume("show strip to mara")
check(output:find("clinical count", 1, true), "Mara acknowledges the measured witness trace")
output = game:resume("show wafer to mara")
check(output:find("Custody is a longer promise", 1, true) and not output:find("Show Ivo", 1, true),
	"Mara acknowledges sample risk and existing consent without stale instructions")
output = game:resume("ask mara about wafer")
check(output:find("Custody is a longer promise", 1, true), "Ordinary sample conversation is not a crew fallback")
output = game:resume("ask mara about crew")
check(output:find("Ivo agreed", 1, true), "Crew advice acknowledges consent already obtained")
enter(env.CORE)
output = game:resume("examine console")
check(output:find("guarded custody", 1, true) and output:find("Erasure destroys", 1, true),
	"Both concrete decision costs are disclosed before commitment")
enter(env.LAUNCH)
output = game:resume("push beacon")
check(output:find("actual memory wafer", 1, true) and not output:find("compare physical foil", 1, true) and not env.EVAC,
	"Departure refusal identifies the remaining containment step rather than replaying completed requirements")
enter(env.HUB)
env.HUB_MILESTONE = -1
output = game:resume("look")
check(output:find("compulsive half-heard", 1, true), "First milestone visit marks the sensory change")
output = game:resume("look")
check(output:find("junction tastes", 1, true) and not output:find("compulsive half-heard", 1, true),
	"Repeated verbose navigation retains the physical room without replaying the haunting beat")
assert(#failures == 0, table.concat(failures, "\n"))
print("Silent Vector blind round 1 parser regressions: ok")
