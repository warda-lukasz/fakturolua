local inspect = require('inspect')

local L = {}

function L.log(any) 
  print(inspect(any))
end

return L
