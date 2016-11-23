type
  Bit = range[0..1]
  Base = seq[int]
  BitVector = distinct Base

# proc `[]`(b: BitVector, i: Slice[int]): BitVector =
#   (if i.a < i.b: Base(b)[i] else: Base(b)[i.b .. i.a])

# proc `[]=`(b: var BitVector; i: Slice[int], value: BitVector) = ...

proc `[]`(b: BitVector, i: int): Bit = Base(b)[i shr 5] shr (i and 31) and 1 # i and 31 is a fast way to do i mod 32

proc `[]=`(b: var BitVector, i: int, value: Bit) =
  var w = addr Base(b)[i shr 5]
  if value == 0: w[] = w[] and not (1'i32 shl (i and 31))
  else: w[] = w[] or (1'i32 shl (i and 31))

proc newBoolBV(n: int, b: bool): BitVector =
    ## New bit packed booleean array, initialized to b bool value
    result = newSeq[int](n+1).BitVector
    if b:
        for i in 0..n:
            result[i]=1