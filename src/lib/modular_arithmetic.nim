# The MIT License (MIT)

# Copyright (c) 2017 Mamy Ratsimbazafy

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from ./integer_math import isOdd


proc mulmod*[T: SomeInteger](a, b, modulus: T): T =
  var a_m = a mod modulus
  var b_m = b mod modulus
  if b_m > a_m:
    swap(a_m, b_m)
  while b_m > 0:
    if b_m.isOdd:
      result = (result + a_m) mod modulus
    a_m = (a_m shl 1) mod modulus
    b_m = b_m shr 1

proc expmod*[T: SomeInteger](base, exponent, modulus: T): T =
  ## Modular exponentiation

  # Formula from applied Cryptography by Bruce Schneier
  # function modular_pow(base, exponent, modulus)
  #     result := 1
  #     while exponent > 0
  #         if (exponent mod 2 == 1):
  #            result := (result * base) mod modulus
  #         exponent := exponent >> 1
  #         base = (base * base) mod modulus
  #     return result

  result = 1 # (exp 0 = 1)

  var e = exponent
  var b = base

  while e > 0:
    if isOdd e:
      result = mulmod(result, b, modulus)
    e = e shr 1 # e div 2
    b = mulmod(b,b,modulus)

proc addmod*[T: SomeInteger](a, b, modulus: T): T =
  let a_m = if a < modulus: a else: a mod modulus

  if b == 0:
    return a_m
  let b_m = if b < modulus: b else: b mod modulus

  # We don't do a + b to avoid overflows
  # But we now that m at least is inferior to biggest T

  let b_from_m = modulus - b_m
  if a_m >= b_from_m:
    result = a_m - b_from_m
  else:
    result = modulus - b_from_m + a_m

when isMainModule:
  # https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/fast-modular-exponentiation
  assert expmod(5, 117,19) == 1
  assert expmod(3, 1993, 17) == 14