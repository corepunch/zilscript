local Walk = require("tests.story_walk")
local module = ".last-door-of-battleworld.last-door-of-battleworld"
local words = {
  en = {heroes={"spider-man","storm","iron man"}, choose="choose ", north="north", east="east", west="west", south="south",
    coil="take coil", relay="put coil in relay", rescue="focus skiff", winch="pull winch", mirror="examine mirror", turn="turn mirror", box="open cache",
    cell="take cell", drop="drop cell", socket="use socket", light="use loom", power="focus loom",
    doom="strike doom", endText="THE LAST DOOR STAYS OPEN"},
  ru = {heroes={"паука","грозу","железного человека"}, choose="выбрать ", north="север", east="восток", west="запад", south="юг",
    coil="взять катушку", relay="использовать передатчик", rescue="спасти челнок", winch="потянуть лебёдку", mirror="осмотреть зеркало", turn="повернуть зеркало", box="открыть ящик",
    cell="взять батарею", drop="бросить батарею", socket="применить гнездо", light="использовать станок",
    power="применить станок", doom="ударить дума", endText="ПОСЛЕДНЯЯ ДВЕРЬ"},
}
local function has(w, cmd)
  for _,c in ipairs(w.game:resume("choices").choices) do if c.command==cmd then return true end end
  return false
end
local function play(w, cmd, fromChoices)
  if fromChoices then assert(has(w,cmd), "not in companion menu: "..cmd.." at "..w:room()) end
  local o = w.game:resume(cmd)
  assert(type(o)=="string" and o:find("%S") and utf8.len(o), cmd)
  w:record(o)
  return o
end
for lang,t in pairs(words) do
  for hero=1,3 do
    for route=1,2 do
      local w=Walk.new("books."..lang..module,97)
      local e=w.env
      e.math.random=function() return route==1 and 100 or 1 end
      play(w,t.choose..t.heroes[hero],true)
      assert(e.RPG_PRESET_INDEX==hero and e.HERE==e.LANDING and e.MOVES==0)
      play(w,t.coil,true)
      play(w,t.north,true)
      play(w,t.relay,true)
      play(w,t.north,true)
      assert(e.HERE==e.CAMP)
      local health = e.STAT(e.HERO,e.A_HEALTH)
      local karma = e.STAT(e.HERO,e.A_KARMA)
      play(w,t.north,true)
      play(w,t.north,false)
      assert(e.HERE==e.SPAN, "civilian rescue cannot be bypassed")
      play(w,t.rescue,true)
      if route==2 then
        assert(not e.EVACUATED and e.STAT(e.HERO,e.A_HEALTH)==health-5)
        play(w,t.rescue,false)
        assert(e.STAT(e.HERO,e.A_HEALTH)==health-5, "repeat must not reroll")
        play(w,t.winch,true)
        assert(e.BW_ASSISTED)
      end
      play(w,t.winch,false)
      assert(e.EVACUATED and e.STAT(e.HERO,e.A_KARMA)==karma+10, "one rescue reward only")
      play(w,t.north,true)
      assert(e.HERE==e.MARKET)
      play(w,t.north,true)
      play(w,t.light,false)
      play(w,t.doom,false)
      assert(not e.BW_WON and e.HERE==e.TOWER and w:running(), "unpowered Loom and projection don't end the game")
      play(w,t.south,true)
      if route==1 then
        play(w,t.turn,false)
        assert(not e.BW_ALIGNED)
        play(w,t.mirror,true)
        play(w,t.turn,true)
        assert(e.BW_ALIGNED and not e.BW_CHARGED)
      else
        play(w,t.box,true)
        play(w,t.cell,true)
        assert(e.INQ(e.CELL,e.WINNER))
        play(w,t.east,true)
        play(w,t.drop,false)
        assert(e.LOC(e.CELL)==e.HERE, "dropped battery is recoverable")
        play(w,t.cell,true)
        play(w,t.socket,true)
        assert(e.BW_CHARGED and not e.BW_ALIGNED)
        play(w,t.west,true)
      end
      play(w,t.north,true)
      local out=play(w,route==1 and t.light or t.power,true)
      assert(e.BW_WON==route and not w:running() and w.finishes==1, lang.." "..out)
      assert(e.STAT(e.HERO,e.A_KARMA)==karma+30)
    end
  end
end
print("ok - 12 Battleworld victories: three heroes, two endings, two locales; forced setbacks and recovery")
