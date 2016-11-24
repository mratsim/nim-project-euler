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

proc bit_length*[T: SomeInteger](n: T): T =
  ## Calculates how many bits are necessary to represent the number
  result = 1
  var y: T = n shr 1
  var zero: T = 0 #Needed because unsigned and signed 0 are different ...
  while y > zero:
    y = y shr 1
    inc(result)

proc divmod*[T: SomeInteger](n: T, b: T): (T, T) =
    ## return (n div base, n mod base)
    return (n div b, n mod b)

proc isqrt*[T: SomeInteger](n: T):  T =
    ##integer square root, return the biggest squarable number under n
    ##Computation via Newton method
    var x = n
    const two: T = 2
    var y = (two shl ((n.bit_length()+1) shr 1)) - 1
    while y < x:
        x = y
        y = (x + n div x) shr 1
    return x