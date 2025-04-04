local DM = {}

local monthNames = {
  "Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec",
  "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"
}

function DM.stringDateToTime(dateStr)
  if dateStr == "" then return os.time() end
  local day, month, year = dateStr:match("(%d+).(%d+).(%d+)")

  if not day or not month or not year then
    error("Invalid date format")
  end

  local yearNum, monthNum, dayNum = tonumber(year), tonumber(month), tonumber(day)

  if not (yearNum and monthNum and dayNum) then
    error("Invalid date format")
  end

  return os.time({
    year = yearNum,
    month = monthNum,
    day = dayNum
  })
end

function DM.getCurrentMonthName()
  return monthNames[tonumber(os.date('%m'))]
end

function DM.getLastDayOfTheMonth()
  local month = tonumber(os.date('%m'))
  local year = tonumber(os.date('%Y'))

  if not (month and year) then
  error("Invalid date format")
  end

  local first_day_next_month = os.time({ year = year, month = month + 1, day = 1 })
  local lastDay = tonumber(DM.addDays(first_day_next_month, -1))

  local yearNum, monthNum, dayNum = tonumber(os.date('%Y', lastDay)),
    tonumber(os.date('%m', lastDay)), tonumber(os.date('%d', lastDay))

  if not (yearNum and monthNum and dayNum) then
    error("Invalid date format")
  end

  return os.time({
    year = yearNum,
    month = monthNum,
    day = dayNum
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
