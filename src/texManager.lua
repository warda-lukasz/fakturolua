local console = require('src.utils.log')
local fm = require('src.fileManager')
local TM = {}

function TM.prepareFv(inactive)

  local seller = fm.getSeller()
  local customers = fm.getCustomers()
  local template = fm.getTemplate()
  local templateWithSeller = fm.replaceTemplateVars(template, seller, 'seller')

  for i, customer in pairs(customers) do
    local invoices = customer.invoices

    for i, invoice in pairs(invoices) do

      if invoice.active or inactive == 'inactive' then
        console.log(invoice)
      end

    end

  end

  return templateWithSeller
end

return TM


