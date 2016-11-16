import math
import sequtils
import future
# import nimLazy

iterator fib: int {.closure.} =
  var a = 0
  var b = 1
  while true:
    yield a
    swap a, b
    b = a + b
 
var f = fib

#Failed to implement takewhile due to type check ...
# type filterProc[T] = proc (value:T): bool
# iterator takeWhile*[iT, rT](predicate: filterProc[rT], iter: iT): seq[int] {.closure.} =
#     for element in iter:
#         if predicate(element):
#             yield element


# Ripped off nimLazy
# takeWhile

proc takeWhile*[T](iter: iterator(): T, cond: proc(x: T):bool): iterator(): T =
  ## .. code-block:: Nim
  ##  takeWhile(1;2;3;4, proc(x: int): bool = x < 4) -> 1;2;3
  result = iterator(): T {.closure.}=
    var r = iter()
    while not finished(iter) and cond(r):
      yield r
      r = iter()


echo sum(takeWhile(f, (proc(x:bool): bool = true )))