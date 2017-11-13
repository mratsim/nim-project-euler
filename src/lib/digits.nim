from functional import unfold
from options import Option, some, none

proc divmod10_opt(n: int): Option[(int, int)] =
    if n == 0:
        return none((int,int))
    return some((n mod 10, n div 10))

proc toDigits*(n: int): seq[int] =
    unfold(divmod10_opt,n)

proc divmod10*(n: int): tuple[rem: int, quot: int] =
    if n == 0:
        return (0, 0)
    return (n mod 10, n div 10)