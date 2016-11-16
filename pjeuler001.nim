import sequtils
import future

proc sum (l:seq[int]): int = foldr(l, a + b) # a + b ????? Magic parameters :O

echo sum(lc[x | (x <- 1..999, x mod 3 == 0 or x mod 5 == 0), int])