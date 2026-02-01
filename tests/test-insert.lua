#!/usr/bin/env lua5.4
require "zil"
require "zil.bootstrap"

function ASSERT(...) return assert(...) end

_G.io_write = io.write
_G.io_flush = io.flush

require "tests.test-insert-file"
GO()
io.flush()
