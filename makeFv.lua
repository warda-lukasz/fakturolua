#!/usr/bin/env lua
local tm = require("src.texManager")

local start = os.clock()
local div = string.rep("-", 40)
print('Working... 🧐 \n')
print("\27[32;1m" .. div .. "\27[0m")

tm.prepareFv(arg[1], arg[2])

local stop = os.clock()
print('Done... 😎  Check your output folder 👌')
print("\27[32;1m" .. div .. "\27[0m")
print(string.format("Execution time: \27[36;4;1m %.2f ms \27[0m", (stop - start) * 1000))
