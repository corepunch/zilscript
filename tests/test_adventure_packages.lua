-- Structural regression: package wiring should not reorder declarations.
local function read(path)
 local f = assert(io.open(path, "rb")); local s = f:read("*a"); f:close(); return s
end
local function imports(path)
 local result = {}
 for target in read(path):gmatch('<INSERT%-FILE%s+"([^"]+)"') do result[#result+1] = target end
 return table.concat(result, ",")
end
assert(imports("rulesets/classic/en.zil") == "infocom.zork1.main,core.clock,infocom.zork1.parser,languages.en.init,infocom.zork1.macros,infocom.zork1.verbs,infocom.zork1.globals")
assert(imports("languages/en/init.zil") == "languages.en.syntax")
assert(imports("languages/de/init.zil") == "infocom.zork1-de.tells,infocom.zork1-de.syntax")
assert(imports("infocom/zork1/zork1.zil") == "rulesets.classic.en,dungeon,actions")
assert(imports("books/the-midnight-ledger/the-midnight-ledger.zil") == "rulesets.classic.en,actions,dungeon,companion")
local function normalizedClock(path)
 local source = read(path)
 return (assert(source:match("(<CONSTANT C%-TABLELEN.*)")):gsub(";[^\n]*",""):gsub("%s+",""))
end
assert(normalizedClock("core/clock.zil") == normalizedClock("infocom/zork1-de/clock.zil"), "reference clock logic diverged")
assert(imports("infocom/zork1/clock.zil") == "core.clock")
assert(imports("infocom/zork1/syntax.zil") == "languages.en.syntax")
print("ok - adventure package structure and shared clock")
