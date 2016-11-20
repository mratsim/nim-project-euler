# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

from lib_euler_functional import unfold
from future import `=>`,lc,`[]`
from options import Option, some, none
from lib_euler_openarray import reverse
from sequtils import filter

proc divmod10(n: int): Option[(int, int)] =
    if n == 0:
        return none((int,int))
    return some(( (n mod 10).int(), n div 10))

proc toDigits(n: int): seq[int] =
    unfold(divmod10,n)

proc isPalindrome(n: int) : bool =
    n.toDigits() == n.toDigits().reverse()

echo lc[ x*y | (x <- 100..999, y <- 100..999), int].filter(isPalindrome).max()