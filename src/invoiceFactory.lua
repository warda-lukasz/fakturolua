local console = require('src.utils.log')
local numberFormatter = require('src.utils.numberFormatter')

local IF = {}

local function calculateGross(net, vat)
  return net + net * vat / 100
end

local function calculateVat()

end





function IF.createInvoice(invoiceObj)
  local invoice = invoiceObj

  invoice.gross = calculateGross(invoice.net, invoice.vat)
  invoice.currencyNet = numberFormatter.currencyFormat(invoice.net)
  invoice.currencyGross = numberFormatter.currencyFormat(invoice.gross)
  invoice.currencyVat = calculateVat()
  invoice.vatRate = invoice.vat .. '%'
  invoice.currencySpellout = numberFormatter.currencySpellout(invoice.net)
  invoice.title = ''
  invoice.paymentDate = ''


  return invoice
end

return IF
