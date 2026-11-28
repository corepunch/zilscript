-- Regression checks for the reader-visible defects in the six-book playtest.
package.path = './?.lua;./?/init.lua;' .. package.path
local Walk = require('tests.story_walk')
local function game(name) return Walk.new('books.' .. name .. '.' .. name, 97) end
local w = game('silent-vector')
w:play({'push habitat breaker','north','north','tell doctor mara'})
w:command('tell doctor mara about physical crew')
assert(w.output:find('clinical log', 1, true))
w:play({'north','east','tell researcher senn'})
w:command('tell researcher senn about missing daughter')
assert(w.output:find('thirty-one', 1, true))
local bh = game('blackwood-horror')
bh:play({'north','north','examine metal cabinet','take surgical scalpel','south','east'})
bh:play({{'cut thick chains with surgical scalpel', expect='strap parts'}, 'north'})
bh:play({'south','west','down','down','east','examine iron boiler','take coal shovel','west','west','examine sagging shelves','take oil lantern','turn on oil lantern','east','north','north','north','east','north','north','west','north'})
bh:play({{'dig dead garden with coal shovel', expect='dig into the dead earth'}})
print("ok - reported story interaction defects")
