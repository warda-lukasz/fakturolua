local dm = require('src.utils.datesManager')
local nf = require('src.utils.numberFormatter')

local IF = {}

local function calculateGross(net, vat)
  return math.floor((net + net * vat / 100) * 100 + 0.5) / 100
end

local function calculateVat(net, vat)
  return math.floor((net * vat / 100) * 100 + 0.5) / 100
end

local function prepareCurrencies(i)
  i.gross = calculateGross(i.net, i.vat)
  i.currencyNet = nf.currencyFormat(i.net)
  i.currencyGross = nf.currencyFormat(i.gross)
  i.currencyVat = nf.currencyFormat(calculateVat(i.net, i.vat))
  i.vatRate = i.vat .. '%'
  i.currencySpellout = nf.currencySpellout(i.net)
end

local function prepareDates(i)
  dm.prepareIssueDate(i)
  dm.prepareSaleDate(i)
  dm.preparePaymentDate(i)

  i.issueDate = os.date('%d.%m.%Y', i.issueDate)
  i.saleDate = os.date('%d.%m.%Y', i.saleDate)
  i.paymentDate = os.date('%d.%m.%Y', i.paymentDate)
end

local function prepareTitles(i, fvIndex, seller)
  i.title = fvIndex .. '/' .. os.date('%m/%Y')
  i.filename = seller.invoiceTitlePrefix .. fvIndex .. '_' .. os.date('%m_%Y')
end

function IF.createInvoice(invoiceObj, index, seller)
  local invoice = invoiceObj

  prepareTitles(invoice, index, seller)
  prepareCurrencies(invoice)
  prepareDates(invoice)

  return invoice
end

return IF
