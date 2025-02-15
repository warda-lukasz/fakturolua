local invoiceFactory = require('src.invoiceFactory')
local fm = require('src.fileManager')
local TM = {}

function TM.prepareFv(inactive)
  local seller = fm.getSeller()
  local customers = fm.getCustomers()
  local template = fm.getTemplate()
  local templateWithSeller = fm.replaceTemplateVars(template, seller, 'seller')
  local invoiceIndex = 1

  for i, customer in pairs(customers) do
    local customerTemplate = fm.replaceTemplateVars(templateWithSeller, customer, 'customer')
    local invoices = customer.invoices

    for j, invoiceObj in pairs(invoices) do
      if invoiceObj.active or inactive == 'inactive' then
        local invoice = invoiceFactory.createInvoice(invoiceObj, invoiceIndex, seller)
        invoiceIndex = invoiceIndex + 1

        local invoiceTemplate = fm.replaceTemplateVars(customerTemplate, invoice, 'invoice')

        print(invoiceTemplate)

        -- local invoice = invoiceFactory.createInvoice(invoiceObj)
        -- local invoiceTemplate = fm.replaceTemplateVars(templateWithSeller, invoice, 'invoice')
      end
    end
  end

  return templateWithSeller
end

return TM
