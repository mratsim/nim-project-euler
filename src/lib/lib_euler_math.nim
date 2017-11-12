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

from lib_euler_bithacks import bit_length

iterator fib*: int {.closure.} =
  var a = 0
  var b = 1
  while true:
    yield a
    swap a, b
    b = a + b

proc isOdd*[T: SomeInteger](i: T): bool = (i and 1) != 0
proc isEven*[T: SomeInteger](i: T): bool = (i and 1) == 0

proc divmod*[T: SomeInteger](n: T, b: T): (T, T) =
    ## return (n div base, n mod base)
    return (n div b, n mod b)

proc isqrt*[T: SomeInteger](n: T):  T =
    ##integer square root, return the biggest squarable number under n
    ##Computation via Newton method
    var x = n
    const two: T = 2 #necessary to cover uint and int
    var y = (two shl ((n.bit_length()+1) shr 1)) - 1
    while y < x:
        x = y
        y = (x + n div x) shr 1
    return x


proc product*[T](x: openArray[T]): T {.noSideEffect.} =
  ## Computes the sum of the elements in `x`.
  ## If `x` is empty, 0 is returned.
  result = 1
  for i in items(x): result = result * i