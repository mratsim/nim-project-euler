## Number letter counts

# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
#
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.


import tables, sequtils

let map = { # 1000: "thousand",
            100: "hundred",
            90: "ninety",
            80: "eighty",
            70: "seventy",
            60: "sixty",
            50: "fifty",
            40: "forty",
            30: "thirty",
            20: "twenty",
            19: "nineteen",
            18: "eighteen",
            17: "seventeen",
            16: "sixteen",
            15: "fifteen",
            14: "fourteen",
            13: "thirteen",
            12: "twelve",
            11: "eleven",
            10: "ten",
            9: "nine",
            8: "eight",
            7: "seven",
            6: "six",
            5: "five",
            4: "four",
            3: "three",
            2: "two",
            1: "one"
            # 0 is never written
            }.toTable

proc n_to_string(n: Positive): string =
  result = ""

  if n == 1000:
    return "onethousand"

  let hundreds = n div 100
  if hundreds > 0:
    result &= map[hundreds] & "hundred"

  let mod100 = n mod 100
  if map.contains(mod100):
    if result != "":
      result &= "and"
    result &= map[mod100]
    return

  let tens = mod100 div 10
  if tens > 0:
    if result != "":
      result &= "and"
    result &= map[tens * 10]

  let units = n mod 10
  if units > 0:
    result &= map[units]


echo toSeq(1..1000).foldl(a + b.n_to_string.len, 0)
