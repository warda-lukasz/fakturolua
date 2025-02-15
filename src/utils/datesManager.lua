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

function DM.getIssueTimeFromConfig(invoice)
  return os.time({
    year = os.date('%Y', invoice.dateToIssue),
    month = os.date('%m', invoice.dateToIssue),
    day = os.date('%d', invoice.dateToIssue)
  })
end

return DM
