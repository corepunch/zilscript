local utils = require "translator.utils"
local parser = {}

local function car(c) return c[1] end
local function cdr(c) return c[2] end

local function to_lisp(arr, i) i = i or 1
  return i < #arr and { arr[i], to_lisp(arr, i + 1) } or nil
end

local function is(word, class) if not word then return false end
  for i = 1, #class do
		if word:sub(1,1):upper() == class:sub(i,i) then return true end
	end
end

local function has(t, class) if not t then return false end
  for i = 1, #t do
		if is(t[i], class) then return t[i] end
	end
  return false
end

local function find(t, s) if not t then return false end
	for i = 1, #s do for j = 1, #t do
		if is(t[j], s:sub(i,i)) then return t[j] end
	end end
end

-- существительное
local function noun(t, prev, next)
  return find(t, "N") or t[1]
end

-- прилагательное перед существительным
local function adj(t, prev, next)
  return has(next, "N") and find(t, "A") or noun(t, prev, next)
end

-- глагол после местоимения
local function verb(t, prev, next)
	print(prev, is(prev, "RN"), utils.debug(t))
	return is(prev, "RN") and find(t, "VZ") or adj(t, prev, next)
end

-- местоимение
local function choose(t, prev, next)
  if #t == 1 then return t[1] end
	return find(t, "R") or verb(t, prev, next)
end

function parser.collect(ts)
  local out = {}
	local prev = nil
	local list = to_lisp(ts)
  for i, t in ipairs(ts) do
		prev = choose(t, prev, ts[i+1])
		table.insert(out, prev)
  end
  return out
end

return parser