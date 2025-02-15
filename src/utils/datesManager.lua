local DM = {}

local monthNames = {
  "Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec",
  "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"
}

function DM.stringDateToTime(dateStr)
  if dateStr == "" then return os.time() end
  local day, month, year = dateStr:match("(%d+).(%d+).(%d+)")

  if not day or not month or not year then
    error("Invalid date format: " .. dateStr)
  end

  return os.time({
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day)
  })
end

function DM.getCurrentMonthName()
  return monthNames[tonumber(os.date('%m'))]
end

function DM.getLastDayOfTheMonth()
  local month = os.date('%m')
  local year = os.date('%Y')
  local first_day_next_month = os.time({ year = year, month = month + 1, day = 1 })
  local lastDay = DM.addDays(first_day_next_month, -1)

  return os.time({
    year = os.date('%Y', lastDay),
    month = os.date('%m', lastDay),
    day = os.date('%d', lastDay)
  })
end

function DM.addDays(date, days)
  return date + (days * 24 * 60 * 60)
end

function DM.getIssueTimeFromConfig(i)
  return DM.stringDateToTime(i.dateToIssue)
end

function DM.getSaleTimeFromConfig(i)
  return DM.stringDateToTime(i.dateToSale)
end

function DM.prepareIssueDate(i)
  if i.issueOnTheLastDay then
    i.issueDate = DM.getLastDayOfTheMonth()
  else
    if i.dateToIssue ~= "" then
      i.issueDate = DM.getIssueTimeFromConfig(i)
    else
      i.issueDate = os.time()
    end
  end
end

function DM.prepareSaleDate(i)
  if (i.issueOnTheLastDay) then
    i.saleDate = DM.getLastDayOfTheMonth()
  else
    if i.dateToIssue ~= "" then
      i.saleDate = DM.getSaleTimeFromConfig(i)
    else
      i.saleDate = os.time()
    end
  end
end

function DM.preparePaymentDate(i)
  i.paymentDate = DM.addDays(i.issueDate, i.daysToPayment)
end

return DM
