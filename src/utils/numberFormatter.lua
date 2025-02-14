local NF = {}

local singles = {
  [0] = "",
  "jeden",
  "dwa",
  "trzy",
  "cztery",
  "pięć",
  "sześć",
  "siedem",
  "osiem",
  "dziewięć"
}

local teens = {
  [0] = "",
  "jedenaście",
  "dwanaście",
  "trzynaście",
  "czternaście",
  "piętnaście",
  "szesnaście",
  "siedemnaście",
  "osiemnaście",
  "dziewiętnaście"
}

local dozens = {
  [0] = "",
  "dziesięć",
  "dwadzieścia",
  "trzydzieści",
  "czterdzieści",
  "pięćdziesiąt",
  "sześćdziesiąt",
  "siedemdziesiąt",
  "osiemdziesiąt",
  "dziewięćdziesiąt"
}

local hundreds = {
  [0] = "",
  "sto",
  "dwieście",
  "trzysta",
  "czterysta",
  "pięćset",
  "sześćset",
  "siedemset",
  "osiemset",
  "dziewięćset"
}

local thousandsDeclension = {
  [0] = "", "tysiąc", "tysiące", "tysięcy"
}

local polishCurrencyDeclension = {
  [0] = "złoty", "złote", "złotych"
}

local polishCentsDeclension = {
  [0] = "grosz", "grosze", "groszy"
}

local function spelloutHundreds(num)
  local w = ""
  local h = math.floor(num / 100)        -- hundreds
  local d = math.floor((num % 100) / 10) -- dozens
  local s = num % 10                     -- singles

  if h > 0 then
    w = w .. hundreds[h] .. " "
  end

  if d == 1 and s > 0 then
    w = w .. teens[s] .. " "
  else
    if d > 0 then
      w = w .. dozens[d] .. " "
    end

    if s > 0 then
      w = w .. singles[s] .. " "
    end
  end

  return w
end

local function parseThousands(whole)
  local thousands = math.floor(whole / 1000)
  local rest = whole % 1000
  local result = ''

  if thousands > 0 then
    if thousands == 1 then
      result = thousandsDeclension[1] .. " "
    else
      local howManyThousands = thousands % 10
      local howManyDozens = math.floor(thousands % 100 / 10)
      result = spelloutHundreds(thousands)

      if howManyThousands >= 2 and howManyThousands <= 4 and howManyDozens ~= 1 then
        result = result .. thousandsDeclension[2] .. " "
      else
        result = result .. thousandsDeclension[3] .. " "
      end
    end
  end

  return {
    result = result,
    rest = rest
  }
end

local function parseHundreds(thousands)
  local result = thousands.result

  if thousands.rest > 0 then
    result = result .. spelloutHundreds(thousands.rest)
  end

  return result
end

local function parseCurrencyDeclension(result, num)
  if num == 1 then
    result = result .. polishCurrencyDeclension[0]
  elseif num % 10 >= 2 and num % 10 <= 4 and math.floor(num % 100 / 10) ~= 1 then
    result = result .. polishCurrencyDeclension[1]
  else
    result = result .. polishCurrencyDeclension[2]
  end

  return result
end

local function parseCentsDeclension(result, num)
  if num > 0 then
    result = result .. " i " .. spelloutHundreds(num)

    if num == 1 then
      result = result .. polishCentsDeclension[0]
    elseif num % 10 >= 2 and num % 10 <= 4 and math.floor(num % 100 / 10) ~= 1 then
      result = result .. " " .. polishCentsDeclension[1]
    else
      result = result .. " " .. polishCentsDeclension[2]
    end
  end

  return result
end

function NF.currencySpellout(num)
  local result = ""
  local whole = math.floor(num)
  local cents = math.floor((num * 100) % 100)

  result = parseHundreds(parseThousands(whole))
  result = parseCurrencyDeclension(result, whole)
  result = parseCentsDeclension(result, cents)

  return result
end

function NF.currencyFormat(num)
  return string.format("%.2f", num) .. " zł"
end

return NF
