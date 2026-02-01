#!/usr/bin/env lua5.4
-- Test the simplified ASSERT function
require "zil"
require "zil.bootstrap"

ENABLE_DIRECT_OUTPUT()
require "tests.test-simple-new"
GO()
