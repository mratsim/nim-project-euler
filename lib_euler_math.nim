# The MIT License (MIT)

# Copyright (c) 2016 Mamy Ratsimbazafy

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

iterator fib*: int {.closure.} =
  var a = 0
  var b = 1
  while true:
    yield a
    swap a, b
    b = a + b

proc isOdd*(i: SomeInteger): bool {.procvar.} = (i and 1) != 0
proc isEven*(i: SomeInteger): bool {.procvar.} = (i and 1) == 0

proc expmod*(base: int, exponent: int, modulus: int): int =
    if modulus == 1: return 0
    #Should assert overflow of (modulus - 1) * (modulus - 1)
    result = 1
    var b = base mod modulus
    var e = exponent

    while e > 0:
        if e.isOdd():
           result = (result * b) mod modulus
        e = e * 2 #Use shift operator ?
        b = (b * b) mod modulus