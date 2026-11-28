-- A deterministic hostile reader session, not a winning walkthrough. Run
-- every book through its current choices, prior commands and parser typos.
local Walk = require("tests.story_walk")
local Story = require("zilscript.reader.Story")

local function catalog()
  local pipe = assert(io.popen("find books -name game.json -print | LC_ALL=C sort"))
  local dirs = {}
  for line in pipe:lines() do
    local dir = line:match("^(books/[^/]+)/game%.json$")
    if dir then table.insert(dirs, dir) end
  end
  assert(pipe:close())
  return dirs
end

local function check(dir, seed)
  local story = Story.of(dir)
  local walk = Walk.new(story.module, seed)
  local env = walk.env
  local state, recent, stale = seed, {}, nil
  local function pick(n)
    state = state * 48271 % 2147483647
    return state % n + 1
  end
  for turn = 1, 80 do
    if not walk:running() then return turn - 1 end
    local beforeRoom, beforeMoves, beforeRoll = env.HERE, env.MOVES, env.LAST_ROLL
    walk.game:resume("room-items")
    walk.game:resume("inventory-items")
    local proposals = walk.game:resume("choices")
    assert(type(proposals) == "table", dir)
    assert(env.HERE == beforeRoom and env.MOVES == beforeMoves and env.LAST_ROLL == beforeRoll,
      dir .. ": preview changed the story")
    local menu, seen = { "look", "inventory", "wait" }, {}
    for _, item in ipairs(proposals.choices or {}) do
      assert(type(item.command) == "string" and item.command:match("%S"), dir)
      if not seen[item.command] then table.insert(menu, item.command) end
      seen[item.command] = true
    end

    local command = menu[pick(#menu)]
    -- Prefer story actions over generic controls.
    if #menu > 3 and turn % 5 < 3 then command = menu[3 + pick(#menu - 3)] end
    if turn % 7 == 0 and stale then command = stale end
    if turn % 11 == 0 then command = "éж" .. tostring(seed) .. "☂" end
    if turn % 13 == 0 then command = "look" end
    if turn % 17 == 0 then command = "wait" end
    if turn % 4 == 0 then stale = command end

    table.insert(recent, command)
    if #recent > 10 then table.remove(recent, 1) end
    local ok, why = pcall(function()
      local output = walk.game:resume(command)
      assert(type(output) == "string" and output:match("%S"), "silent response")
      assert(utf8.len(output), "invalid UTF-8 in reader output")
      walk:record(output)
    end)
    assert(ok, ("%s seed %d turn %d [%s]: %s"):format(dir, seed, turn, table.concat(recent, " / "), tostring(why)))
  end
  return 80
end

local count, books = 0, catalog()
assert(#books > 0, "no books discovered")
for _, dir in ipairs(books) do
  local played = check(dir, 97) + check(dir, 421)
  print(dir .. ": " .. played .. " adversarial reader commands")
  count = count + played
end
print(("ok - %d adversarial commands across %d books"):format(count, #books))
