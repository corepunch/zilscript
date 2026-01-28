-- Comprehensive test for NEXTP function
local bootstrap = require 'zil.bootstrap'

print("Testing NEXTP function comprehensively:")
print("=======================================\n")

-- Test 1: Basic iteration
print("Test 1: Basic property iteration")
local obj1 = DECL_OBJECT("TEST1")
OBJECT({NAME="TEST1", DESC="Test", LDESC="Long desc", ACTION="Act"})

local props = {}
local p = 0
while true do
  p = NEXTP(obj1, p)
  if p == 0 then break end
  table.insert(props, p)
end
print(string.format("  Found %d properties: %s", #props, table.concat(props, ", ")))
assert(#props >= 2, "Should have at least 2 properties")

-- Test 2: Starting from middle
print("\nTest 2: Starting from middle property")
if props[2] then
  local p2 = NEXTP(obj1, props[2])
  if props[3] then
    assert(p2 == props[3], "Should get next property")
    print(string.format("  ✓ NEXTP(%d) = %d (correct)", props[2], p2))
  else
    assert(p2 == 0, "Should get 0 when no more properties")
    print(string.format("  ✓ NEXTP(%d) = 0 (end of list)", props[2]))
  end
end

-- Test 3: Edge case - last property
print("\nTest 3: Edge case - last property")
local last_prop = props[#props]
local after_last = NEXTP(obj1, last_prop)
assert(after_last == 0, "NEXTP of last property should return 0")
print(string.format("  ✓ NEXTP(%d) = 0 (correct)", last_prop))

-- Test 4: Edge case - starting with 0
print("\nTest 4: Edge case - starting with 0")
local first = NEXTP(obj1, 0)
assert(first == props[1], "NEXTP(0) should return first property")
print(string.format("  ✓ NEXTP(0) = %d (first property)", first))

-- Test 5: Object with no custom properties (just NAME)
print("\nTest 5: Object with minimal properties")
local obj2 = DECL_OBJECT("MINIMAL")
OBJECT({NAME="MINIMAL"})
local p5 = NEXTP(obj2, 0)
-- Should have at least 0 or some system properties
print(string.format("  First property: %d", p5))

print("\n✓ All NEXTP tests passed!")
