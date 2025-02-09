local console = require('src.utils.log')
local numberFormatter = require('src.utils.numberFormatter')

local IF = {}

function IF.createInvoice(invoiceObj) 
  local invoice = invoiceObj

  invoice.currencyNet = ''
  invoice.currencyGross =''
  invoice.currencyVat = ''
  vatRate = invoice.vat .. '%'
  -- invoice.currencySpellout = numberFormatter.currencySpellout(invoice.net)
  invoice.title = ''
  invoice.paymentDate = ''

  numberFormatter.currencySpellout(10.5)
  numberFormatter.currencySpellout(152.34)
  numberFormatter.currencySpellout(100)
  numberFormatter.currencySpellout(1000)
  numberFormatter.currencySpellout(10000)
  numberFormatter.currencySpellout(10204)

  return 
end

return IF


