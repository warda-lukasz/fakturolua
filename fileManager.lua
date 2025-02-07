local loader = require('loader')
local console = require('utils.log')

local FM = {}

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

function FM.prepareFv() 
  local seller = loader.loadYaml('config/seller.yaml')
  local customers = loader.loadYaml('config/customers.yaml')
  local template = FM.getTemplate()
  local templateWithSeller = FM.replaceTemplateVars(template, seller, 'seller')

  for i, customer in pairs(customers) do
    console.log(customer)
  end

  return templateWithSeller
end

return FM
