local DM = {}

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
  return os.time({
    year = os.date('%Y', i.dateToIssue),
    month = os.date('%m', i.dateToIssue),
    day = os.date('%d', i.dateToIssue)
  })
end

function DM.getSaleTimeFromConfig(i)
  return os.time({
    year = os.date('%Y', i.dateToSale),
    month = os.date('%m', i.dateToSale),
    day = os.date('%d', i.dateToSale)
  })
end

return DM
