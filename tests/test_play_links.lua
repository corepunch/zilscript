local routePath = os.tmpname()
local route = assert(io.open(routePath, "w"))
assert(route:write("!north\neast\n"))
assert(route:close())

local quotedPath = "'" .. routePath:gsub("'", "'\\''") .. "'"
local replay = assert(io.popen("lua scripts/play-links.lua blackwood-horror " .. quotedPath .. " 2 2>&1", "r"))
local output = replay:read("*a")
local ok = replay:close()
os.remove(routePath)

assert(ok, "Sanitarium route should reach the patient ward after !north and east:\n" .. output)
assert(output:find("PARSER> north\n", 1, true), "North should run as a parser diagnostic")
assert(output:find("> east\n[[Glass]] crunches", 1, true), "East should use the entrance hall's link menu")
print("ok - play-links refreshes Sanitarium's menu after !north")
