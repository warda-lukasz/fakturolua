#!/usr/bin/env lua
local tm = require("src.texManager")
local console = require('src.utils.log')

-- local start = os.clock()

-- print('Working... 🧐 \n')

tm.prepareFv(arg[1])
-- local stop = os.clock()

-- print('Done... 😎  Check your output folder 👌')
-- print('Total execution time: ' .. stop - start .. ' seconds')

