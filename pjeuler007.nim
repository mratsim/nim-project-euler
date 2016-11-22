# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# What is the 10 001st prime number?


# Optim : bitarray
# Optim : Page sgmented sieve
# Optim : Wheel factorization

from os import paramStr, commandLineParams
from strutils import parseUInt
from algorithm import fill
from sequtils import toSeq, apply
from lib_euler_math import isqrt, bit_length
from future import `=>`

type
  Bit = range[0..1]
  Base = seq[int]
  BitVector = distinct Base

# proc `[]`(b: BitVector, i: Slice[int]): BitVector =
#   (if i.a < i.b: Base(b)[i] else: Base(b)[i.b .. i.a])

# proc `[]=`(b: var BitVector; i: Slice[int], value: BitVector) = ...

proc `[]`(b: BitVector, i: int): Bit = Base(b)[i div 32] shr (i mod 32) and 1

proc `[]=`(b: var BitVector, i: int, value: Bit) =
  var w = addr Base(b)[i div 32]
  if value == 0: w[] = w[] and not (1'i32 shl (i mod 32))
  else: w[] = w[] or (1'i32 shl (i mod 32))

proc newBoolBV(n: int, b: bool): BitVector =
    ## New bit packed booleean array, initialized to b bool value
    result = newSeq[int](n.bit_length).BitVector
    if b:
        for i in 0..n:
            result[i]=1
            


# Ideally we should implement items and pairs for proper iterration

proc bitvec_sieve(n: uint): iterator(): uint =
    result = iterator(): uint {.closure.}=
        var a = newBoolBV(n.int, true)
        a[0] = 0
        a[1] = 0
        for i in 2..isqrt(n).int:
            if a[i]==1:
                for j in countup(i shl 1, n.int, i): #cross off multiples from i^2 to n
                    a[j] = 0
        for i in 2..n.int:
            if a[i]==1: yield i.uint




let programName = paramStr(0)
let arguments = commandLineParams()

let r = arguments[0].parseUInt().bitvec_sieve()
echo r().toSeq()

