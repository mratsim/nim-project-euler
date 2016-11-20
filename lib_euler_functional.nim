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


# Ripped off nimLazy MIT License Peter Mora
# takeWhile, take and count

proc takeWhile*[T](iter: iterator(): T, cond: proc(x: T):bool): iterator(): T =
  ## .. code-block:: Nim
  ##  takeWhile(1;2;3;4, proc(x: int): bool = x < 4) -> 1;2;3
  result = iterator(): T {.closure.}=
    var r = iter()
    while not finished(iter) and cond(r):
      yield r
      r = iter()

proc take*[T](iter: iterator(): T, n: int): iterator(): T =
  ## .. code-block:: Nim
  ##   take(1;2;3;4, 3) -> 1;2;3
  ##   take(1;2, 3) -> 1;2
  result = iterator(): T {.closure.}=
    var i = 0
    while i < n:
      i += 1
      var r = iter()
      if finished(iter):
        break
      yield r

proc take*[T](seq: seq[T], n: int): iterator(): T =
  ## .. code-block:: Nim
  ##   take(1;2;3;4, 3) -> 1;2;3
  ##   take(1;2, 3) -> 1;2  

  result = iterator(): T =
      for i, value in seq: #arr.len()-1
        yield value
        if i == seq.len()-1: break  #TODO TEST: if it's proper stop


# count infinite iterator

proc count*[T](start: T): iterator(): T =
  ## .. code-block:: Nim
  ##   count(x0) -> x0; x0 + 1; x0 + 2; ...
  result = iterator(): T {.closure.} =
    var x = start
    while true:
      yield x
      x = x+1

proc count*[T](start: T, till: T, step: T = 1, includeLast = false):
                                                      iterator(): T =
  ## .. code-block:: Nim
  ##   count(x0, x1) -> x0; x0 + 1; x0 + 2; ...; x1-1
  result = iterator (): T {.closure.} =
    var x = start
    while x < till or (includeLast and x == till):
      yield x
      x = x + step

# no "any", "fold" on arrays :/
proc any*[T](arr: openarray[T], pred: proc(item: T): bool {.closure.}): bool =
  ## Return true if any element of the array respects the predicate
  for i in arr:
    if pred(i):
      return true
  return false

# unfold rewrite with Option monad
from options import Option, isSome, get
proc unfold*[T](f: proc(items: T): Option[(T, T)] {.closure.}, x:T): seq[T] =
    ## Build a sequence from function f: T -> Option(T,T) and a seed of type T
    result = @[]
    var u, r = x

    while f(u).isSome():
        (r, u) = f(u).get()
        result.add(r)