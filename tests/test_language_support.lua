-- Language support in the compiler and runtime: <LANGUAGE> character sets,
-- compile-time conditions, macros that choose code, TELL-TOKENS, the string
-- pool and object numbers above 255.
local test = require 'tests.test_framework'
local parser = require 'zilscript.parser'
local compiler = require 'zilscript.compiler'
local evaluate = require 'zilscript.evaluate'
local runtime = require 'zilscript.runtime'
local check = assert -- each test's own "assert" argument shadows Lua's

local function compile(source, session)
	local result = compiler.compile(parser.parse(source, "test.zil"), "test.lua", { session = session })
	local chunk, err = load(result.combined, "=test")
	assert(chunk, "generated Lua does not load: " .. tostring(err) .. "\n" .. result.combined)
	return result.combined
end

local function routine(code, name)
	return code:match(name .. " = function.-\nend\n") or error(name .. " not in\n" .. code)
end

local function parse_one(source)
	return parser.parse(source, "test.zil")
end

test.describe("LANGUAGE character sets", function(t)
	t.it("decodes German escapes in strings after <LANGUAGE GERMAN>", function(assert)
		local ast = parse_one('<LANGUAGE GERMAN>\n<GLOBAL X "H%ande, %>Ja%<, Stra%se, %Arger">')
		assert.assert_equal(ast[2][2].value, "Hände, »Ja«, Straße, Ärger")
	end)

	t.it("decodes escaped atoms to lowercase vocabulary letters", function(assert)
		-- The dictionary lowercases the ASCII letters; ä has no capital there.
		local ast = parse_one('<LANGUAGE GERMAN>\n<SYNONYM VERLA\\%S H\\%ANDE \\%\\<>')
		assert.assert_equal(ast[2][1].value, "VERLAß")
		assert.assert_equal(ast[2][2].value, "HäNDE")
		assert.assert_equal(ast[2][3].value, "«")
	end)

	t.it("takes the language of the including file", function(assert)
		local ast = parser.parse('<GLOBAL X "sch%on">', "test.zil", { language = "GERMAN" })
		assert.assert_equal(ast[1][2].value, "schön")
	end)

	t.it("leaves percent signs alone without a language", function(assert)
		local ast = parse_one('<GLOBAL X "50%a">\n<SYNONYM FCD\\#3>')
		assert.assert_equal(ast[1][2].value, "50%a")
		assert.assert_equal(ast[2][1].value, "FCD#3")
	end)

	t.it("names non-ASCII words with ASCII Lua identifiers", function(assert)
		local code = compile('<LANGUAGE GERMAN>\n<ROUTINE R () <EQUAL? ,W?H\\%ANDE ,W?VERLA\\%S>>')
		assert.assert_match(code, "WQH_C3_A4NDE")
		assert.assert_match(code, "WQVERLA_C3_9F")
	end)
end)

test.describe("Compile-time conditions", function(t)
	local function truth(source) return evaluate.truth(parse_one(source)[1]) end

	t.it("builds as Infocom's production compiler", function(assert)
		assert.assert_true(truth("<GASSIGNED? ZILCH>"))
		assert.assert_true(truth("<GASSIGNED? PREDGEN>"))
		assert.assert_false(truth("<GASSIGNED? PLUS-MODE>"))
	end)

	t.it("combines tests with AND, OR and NOT", function(assert)
		assert.assert_false(truth("<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>"))
		assert.assert_true(truth("<OR <GASSIGNED? PLUS-MODE> <GASSIGNED? ZILCH>>"))
		assert.assert_true(truth("<NOT <GASSIGNED? PLUS-MODE>>"))
		assert.assert_nil(truth("<AND T <FSET? ,LAMP ,ONBIT>>"))
	end)

	t.it("yields plain values from %<COND> clauses", function(assert)
		local ast = parse_one("<CONSTANT UEXIT %<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> 2) (T 1)>>")
		assert.assert_equal(ast[1][2].value, 1)
	end)
end)

test.describe("Macros that choose code", function(t)
	t.it("chooses a compile-time COND clause and builds its FORM", function(assert)
		local code = compile([[
<DEFMAC RMGL-SIZE ('TBL)
	<COND (<AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE>
	       <FORM - <FORM / <FORM PTSIZE .TBL> 2> 1>)
	      (T <FORM - <FORM PTSIZE .TBL> 1>)>>
<ROUTINE R (SYNS) <ZMEMQB 1 .SYNS <RMGL-SIZE .SYNS>>>]])
		assert.assert_match(routine(code, "R"), "ZMEMQB%(1, m_SYNS, SUB%(PTSIZE%(m_SYNS%), 1%)%)")
	end)

	t.it("compiles a macro that yields a runtime COND inside an expression", function(assert)
		local code = compile([[
<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
	           (T .NUM)>>
<ROUTINE R (X) <COND (<G? <ABS .X> 5> <RTRUE>)>>]])
		assert.assert_match(routine(code, "R"), "LQ%(m_X, 0%)")
	end)

	t.it("knows whether an optional macro argument was passed", function(assert)
		local code = compile([[
<DEFMAC CHANCE ('BASE? "OPTIONAL" 'LOSER?)
	<COND (<ASSIGNED? LOSER?> <FORM ZPROB .BASE?>)
	      (ELSE <FORM G? .BASE? '<RANDOM 100>>)>>
<ROUTINE R () <CHANCE 30>>
<ROUTINE S () <CHANCE 30 T>>]])
		assert.assert_match(routine(code, "R"), "GQ%(30, RANDOM%(100%)%)")
		assert.assert_match(routine(code, "S"), "ZPROB%(30%)")
	end)

	t.it("keeps the compiler's TELL over a source TELL macro", function(assert)
		local code = compile([[
<DEFMAC TELL ("ARGS" A) <FORM PROG () !<MAPF ,LIST <FUNCTION (E) .E> .A>>>
<ROUTINE R () <TELL "Hi" CR>>]])
		assert.assert_match(routine(code, "R"), 'TELL%("Hi", CR%)')
	end)
end)

test.describe("TELL-TOKENS", function(t)
	local tokens = [[
<TELL-TOKENS (CRLF CR) <CRLF>
	DER-NOM * <DER-NOM-PRINT .X>
	D ,PRSO <DPRINT-PRSO>
	D * <DPRINT .X>>
]]

	t.it("runs token forms between runs of text, in order", function(assert)
		local body = routine(compile(tokens .. '<ROUTINE R (O) <TELL "Hier ist " DER-NOM .O "." CR>>'), "R")
		local text, token, rest = body:find('TELL%("Hier ist "%)'), body:find("DER_NOM_PRINT%(m_O%)"), body:find('TELL%("."%)')
		assert.assert_true(text and token and rest and text < token and token < rest, body)
		assert.assert_match(body, "CRLF%(%)")
	end)

	t.it("prefers the variant whose literal argument matches", function(assert)
		local body = routine(compile(tokens .. "<ROUTINE R (O) <TELL D ,PRSO D .O>>"), "R")
		assert.assert_match(body, "DPRINT_PRSO%(%)")
		assert.assert_match(body, "DPRINT%(m_O%)")
	end)

	t.it("belongs to the compile session that declared it", function(assert)
		local session = compiler.newSession()
		compile(tokens, session)
		assert.assert_match(routine(compile("<ROUTINE R (O) <TELL D .O>>", session), "R"), "DPRINT%(m_O%)")
		assert.assert_match(routine(compile("<ROUTINE R (O) <TELL D .O>>"), "R"), "TELL%(D, m_O%)")
	end)
end)

test.describe("Runtime limits", function(t)
	local function write(source)
		local path = os.tmpname() .. ".zil"
		local file = assert(io.open(path, "w"))
		file:write(source)
		file:close()
		return path
	end

	local function load(source)
		local env = runtime.create_game_env()
		assert(runtime.init(env, true))
		env.require("zilscript")
		local path = write(source)
		local ok, loaded = pcall(runtime.load_zil_files, { path }, env, { silent = true })
		os.remove(path)
		return env, ok and loaded, (not ok) and loaded or nil
	end

	local function objects(count, extra)
		local lines = { "<DIRECTIONS NORTH SOUTH>", "<OBJECT ROOMS>" }
		for i = 1, count do
			table.insert(lines, string.format('<OBJECT THING-%d (IN ROOMS) (DESC "thing %d")>', i, i))
		end
		table.insert(lines, extra or "")
		return table.concat(lines, "\n")
	end

	t.it("declares more than 255 objects", function(assert)
		local env, ok, err = load(objects(300, '<ROOM HALL (IN ROOMS) (DESC "Hall") (NORTH TO THING-1)>'))
		assert.assert_true(ok, tostring(err))
		assert.assert_equal(env.GETP(env.THING_300, env.PQDESC), "thing 300")
		assert.assert_equal(env.LOC(env.THING_300), env.ROOMS)
	end)

	t.it("refuses an object above 255 in a byte-sized exit", function(assert)
		local env = runtime.create_game_env()
		check(runtime.init(env, true))
		env.require("zilscript")
		local path = write(objects(300, '<ROOM HALL (IN ROOMS) (DESC "Hall") (NORTH TO THING-299)>'))
		local ok, err = pcall(env.INSERT_FILE, path, "")
		os.remove(path)
		assert.assert_false(ok)
		assert.assert_match(tostring(err), "byte fields hold objects up to 255")
	end)

	t.it("keeps one copy of each string outside story memory", function(assert)
		local env, ok, err = load('<OBJECT ROOMS>\n<OBJECT LAMP (IN ROOMS) (DESC "lamp") (LDESC "A lamp.")>')
		assert.assert_true(ok, tostring(err))
		local bytes_before, before = env.MEMORY_USED()
		env.PUTP(env.LAMP, env.PQLDESC, "A lit lamp.")
		env.PUTP(env.LAMP, env.PQLDESC, "A lit lamp.")
		local bytes_after, after = env.MEMORY_USED()
		assert.assert_equal(after, before + 1)
		assert.assert_equal(bytes_after, bytes_before)
		assert.assert_equal(env.GETP(env.LAMP, env.PQLDESC), "A lit lamp.")
	end)
end)

local success = test.summary()
os.exit(success and 0 or 1)
