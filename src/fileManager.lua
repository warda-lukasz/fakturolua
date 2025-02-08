local loader = require('src.loader')
local console = require('src.utils.log')

local FM = {}
local parameters = loader.loadYaml('config/parameters.yaml')

function FM.replaceTemplateVars(template, obj, objName) 
  return template:gsub('<<' .. objName .. '(.-)>>', function(key)
    local value = obj[key]
    return tostring(value)
  end)
end

function FM.getTemplate() 
  local file = io.open('template/template.tex', 'r')
  local content = file:read('*all')
  file:close()
  return content
end

function FM.saveTexFile(content, title) 
  local file = io.open('output/' .. title .. '.tex', 'w')
  file:write(content)
  file:close()
end

function FM.cleanOutputDir() 
  os.execute('rm -rf output/*')
end

function FM.copyFilesToOutputDir() 
  local targetDir = './todo'
  os.execute('cp -r output/* ' .. targetDir .. '/')
end

function FM.getSeller()
  return parameters.seller
end

function FM.getCustomers()
  return parameters.customers
end

return FM
