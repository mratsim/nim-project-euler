proc bit_length*[T: SomeInteger](n: T): T =
  ## Calculates how many bits are necessary to represent the number
  result = 1
  var y: T = n shr 1
  var zero: T = 0 #Needed because unsigned and signed 0 are different ...
  while y > zero:
    y = y shr 1
    inc(result)


type
  Bit = range[0..1]
  Base = seq[int]
  BitVector = distinct Base

# proc `[]`(b: BitVector, i: Slice[int]): BitVector =
#   (if i.a < i.b: Base(b)[i] else: Base(b)[i.b .. i.a])

# proc `[]=`(b: var BitVector; i: Slice[int], value: BitVector) = ...

proc `[]`*(b: BitVector, i: int): Bit = Base(b)[i shr 5] shr (i and 31) and 1 # i and 31 is a fast way to do i mod 32

proc `[]=`*(b: var BitVector, i: int, value: Bit) =
  # let index = i and 31
  var w = addr Base(b)[i shr 5]

  # Alternative 0 to set bit
  # w[] = w[] and (not (1'i32 shl index)) or (value shl index)

  # Alternative 1 with xor for bitsetter
  # w[] = w[] xor (((-value) xor w[]) and (1'i32 shl index))

  # Alternative 2 bit setter
  if value == 0: w[] = w[] and not (1'i32 shl (i and 31))
  else: w[] = w[] or (1'i32 shl (i and 31))

proc newBoolBV*(n: int, b: bool): BitVector =
    ## New bit packed booleean array, initialized to b bool value
    result = newSeq[int](n+1).BitVector
    if b:
        for i in 0..n:
            result[i]=1