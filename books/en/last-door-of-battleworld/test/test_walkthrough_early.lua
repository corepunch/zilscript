local Walk = require("tests.story_walk")
local cases = {
  en = {choose="choose spider-man", north="north", south="south", coil="take coil",
        drop="drop coil", inspect="examine relay", install="put coil in relay", magneto="examine magneto"},
  ru = {choose="выбрать паука", north="север", south="юг", coil="взять катушку",
        drop="бросить катушку", inspect="осмотреть передатчик", install="использовать передатчик", magneto="осмотреть магнето"},
}
for lang, cmd in pairs(cases) do
  local w = Walk.new("books."..lang..".last-door-of-battleworld.last-door-of-battleworld", 97)
  local e = w.env
  local function play(s) local out=w.game:resume(s); assert(type(out)=="string" and out:find("%S"), s); return out end
  play(cmd.choose)
  assert(e.HERE==e.LANDING and e.MOVES==0)
  play(cmd.magneto)
  play(cmd.north)
  assert(e.HERE==e.RIDGE)
  play(cmd.north)
  assert(e.HERE==e.RIDGE and not e.BW_SHIELD, "unguarded route bypassed")
  play(cmd.inspect)
  play(cmd.south)
  play(cmd.coil)
  play(cmd.north)
  play(cmd.drop)
  assert(e.INQ(e.COIL,e.RIDGE), "coil can be dropped on the ridge")
  local found=false
  for _,choice in ipairs(w.game:resume("choices").choices) do
    if choice.command==cmd.coil then found=true end
  end
  assert(found, "dropped coil remains available in choices")
  play(cmd.coil)
  play(cmd.install)
  assert(e.BW_SHIELD and not e.INQ(e.COIL,e.WINNER), "coil must repair the relay")
  play(cmd.install)
  assert(e.BW_SHIELD, "repair remains stable")
  play(cmd.north)
  assert(e.HERE==e.CAMP)
  play(cmd.south)
  assert(e.HERE==e.RIDGE and e.BW_SHIELD, "the return path stays sheltered")
end
print("ok - Battleworld landing and shield repair in both languages")
for lang, spec in pairs({
  en={heroes={"spider-man","storm","iron man"}, choose="choose ", north="north", south="south", power="focus relay", coil="take coil", install="put coil in relay"},
  ru={heroes={"паука","грозу","железного человека"}, choose="выбрать ", north="север", south="юг", power="применить передатчик", coil="взять катушку", install="использовать передатчик"},
}) do
  for hero=1,3 do
    for _, success in ipairs({true,false}) do
      local w=Walk.new("books."..lang..".last-door-of-battleworld.last-door-of-battleworld",97)
      local e=w.env
      e.math.random=function() return success and 100 or 1 end
      local function play(s) local out=w.game:resume(s); assert(type(out)=="string" and out:find("%S"),s); return out end
      play(spec.choose..spec.heroes[hero]); play(spec.north)
      local health=e.STAT(e.HERO,e.A_HEALTH)
      local karma=e.STAT(e.HERO,e.A_KARMA)
      play(spec.power)
      assert(e.BW_SHIELD_POWER_TRIED and not not e.BW_SHIELD==success, lang.." power outcome "..hero)
      assert(e.STAT(e.HERO,e.A_HEALTH)==health and e.STAT(e.HERO,e.A_KARMA)==karma)
      e.math.random=function() return success and 1 or 100 end
      play(spec.power)
      assert(not not e.BW_SHIELD==success, "power must not reroll")
      if not success then
        play(spec.south); play(spec.coil); play(spec.north); play(spec.install)
        assert(e.BW_SHIELD, "repair remains available after failure")
      end
      play(spec.north); assert(e.HERE==e.CAMP)
    end
  end
end
print("ok - all heroes can protect the ridge or recover from a failed attempt")
