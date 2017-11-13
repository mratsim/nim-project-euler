from functional import unfold
from options import Option, some, none

proc divmod10(n: int): Option[(int, int)] =
    if n == 0:
        return none((int,int))
    return some(( (n mod 10).int(), n div 10)) #TODO: understand the weird type of n mod 10

proc toDigits*(n: int): seq[int] =
    unfold(divmod10,n)