local console = require("src.utils.log")
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

function parseThousands(whole)
  local thousands = math.floor(whole / 1000)
  local rest = whole % 1000
  local result = ''

  if thousands > 0 then
    if thousands == 1 then
      result = thousandsDeclension[1] .. " "
    else
      howManyThousands = thousands % 10
      howManyDozens = math.floor(thousands % 100 / 10)
      result = spelloutHundreds(thousands)

      if howManyThousands >= 2 and howManyThousands <= 4 and howManyDozens ~= 1 then
        result = result .. thuosandsDeclension[2] .. " "
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

function parseHundreds(thousands)
  local result = thousands.result

  if thousands.rest > 0 then
    result = result .. spelloutHundreds(thousands.rest)
  end

  return result
end

function parseCurrencyDeclension(result, num)
  print(result)
end

function NF.currencySpellout(number)
  local result = ""
  local whole = math.floor(number)
  local cents = math.floor((number * 100) % 100)

  result = parseCurrencyDeclension(
    parseHundreds(parseThousands(whole)), number
  )

  -- todo and whole cents

  return result
end

function NF.currencyFormat(number) end

function NF.currency_spellout(liczba)
  local calkowita = math.floor(liczba)
  local grosze = math.floor((liczba * 100) % 100)
  local wynik = ""

  -- Dodanie "złote/złotych"
  if calkowita == 1 then
    wynik = wynik .. "złoty"
  elseif calkowita % 10 >= 2 and calkowita % 10 <= 4 and math.floor(calkowita % 100 / 10) ~= 1 then
    wynik = wynik .. "złote"
  else
    wynik = wynik .. "złotych"
  end

  -- Dodanie groszy
  if grosze > 0 then
    wynik = wynik .. " i " .. convert_hundreds(grosze)
    if grosze == 1 then
      wynik = wynik .. "grosz"
    elseif grosze % 10 >= 2 and grosze % 10 <= 4 and math.floor(grosze % 100 / 10) ~= 1 then
      wynik = wynik .. "grosze"
    else
      wynik = wynik .. "groszy"
    end
  end

  return wynik
end

return NF
