local parser = require 'zil.parser'
local compiler = require 'zil.compiler'

local code = [[
<ROUTINE PROB (N) <RETURN .N>>
<ROUTINE TEST (X Y "AUX" Z)
  <SET Z <+ .X .Y>>
  <COND (<PROB .Z> <RETURN .Z>)>>
]]

local ast = parser.parse(code)
local result = compiler.compile(ast)

print("=== Current implementation with _local suffix ===")
print(result.declarations:match("TEST = function.-\nend"))
