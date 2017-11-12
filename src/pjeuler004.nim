# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

from lib/lib_euler_digits import isPalindrome
from future import `=>`,lc,`[]`
# from algorithm import reverse
from sequtils import filter


echo lc[ x*y | (x <- 100..999, y <- 100..999, isPalindrome(x*y)), int].max()