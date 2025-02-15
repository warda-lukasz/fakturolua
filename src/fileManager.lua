local loader = require('src.loader')
local dm = require('src.utils.datesManager')

local FM = {}

local parameters = loader.loadYaml('config/parameters.yaml')
if not parameters then error('Parameters file not found') end

function FM.replaceTemplateVars(template, obj, objName)
  return template:gsub('<<' .. objName .. '(.-)>>', function(key)
    local value = obj[key]

    if value == nil then
      error(string.format("Key '%s' not found in object '%s'", key, objName))
    end

    return tostring(value)
  end)
end

function FM.getTemplate()
  local file = io.open('template/template.tex', 'r')

  if not file then error('Template file not found') end

  local content = file:read('*all')
  file:close()
  return content
end

function FM.saveTexFile(content, filename)
  local file = io.open('tmp/' .. filename .. '.tex', 'w')
  if not file then error('Could not create file') end
  file:write(content)
  file:close()
end

function FM.cleanTmpDir()
  os.execute('rm -rf tmp/*')
end

function FM.moveFilesToOutputDir()
  local targetDir = parameters and parameters.outputDir

  if not targetDir then error('Output directory not set') end

  local writable = os.execute('test -e "' .. targetDir .. '"')

  if not writable then error('Output directory not writable') end

  targetDir = targetDir .. '/' .. os.date('%Y') .. '/'
      .. os.date('%m') .. '-' .. dm.getCurrentMonthName() .. '/'

  os.execute('mkdir -p ' .. targetDir)
  os.execute('cp -r tmp/*.pdf ' .. targetDir .. '/')
end

function FM.getSeller()
  return parameters and parameters.seller
end

function FM.getCustomers()
  return parameters and parameters.customers
end

return FM
