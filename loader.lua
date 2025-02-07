local lyaml = require('lyaml')

local M = {}

function M.loadYaml(file) 
  local file = io.open(file, 'r')
  
  if file then
    local content = file:read('*all')
    file:close()
    return lyaml.load(content)
  end

  print('File not found')
  return 
end

return M
