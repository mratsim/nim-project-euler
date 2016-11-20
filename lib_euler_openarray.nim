



# Rip off def: http://forum.nim-lang.org/t/2057

proc reverse*[T](xs: openarray[T]): seq[T] =
  ## Reverse the sequence
  result = newSeq[T](xs.len)
  for i, x in xs:
    result[^i-1] = x # or: result[xs.high-i] = x