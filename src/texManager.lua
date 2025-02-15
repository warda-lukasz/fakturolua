local invoiceFactory = require('src.invoiceFactory')
local fm = require('src.fileManager')
local TM = {}

local function renderInvoices()
  local files = io.popen('find tmp -name "*.tex"')

  if not files then error('No files found') end

  for file in files:lines() do
    local cmd = string.format('pdflatex -interaction=batchmode -output-directory=tmp %s > /dev/null 2>&1', file)
    local success = os.execute(cmd)

    if not success then error('Could not render file') end
  end

  files:close()
end

function TM.prepareFv(inactiveArg, starterIndex)
  local seller = fm.getSeller()
  local customers = fm.getCustomers()
  local template = fm.getTemplate()
  local templateWithSeller = fm.replaceTemplateVars(template, seller, 'seller')
  local invoiceIndex = starterIndex and starterIndex or 1
  local inactive = inactiveArg == 'true' or inactiveArg and false

  for i, customer in pairs(customers) do
    local customerTemplate = fm.replaceTemplateVars(templateWithSeller, customer, 'customer')
    local invoices = customer.invoices

    for j, invoiceObj in pairs(invoices) do
      if invoiceObj.active or inactive then
        local invoice = invoiceFactory.createInvoice(invoiceObj, invoiceIndex, seller)
        invoiceIndex = invoiceIndex + 1

        local invoiceTemplate = fm.replaceTemplateVars(customerTemplate, invoice, 'invoice')

        fm.saveTexFile(invoiceTemplate, invoice.filename)
      end
    end
  end

  renderInvoices()
  fm.moveFilesToOutputDir()
  fm.cleanTmpDir()
end

return TM
