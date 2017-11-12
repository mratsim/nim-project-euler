# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600851475143 ?

from lib/lib_euler_primes import primFac_pollardRho
# from os import paramStr, commandLineParams
# from strutils import parseInt
from random import randomize


# initialize random seed
randomize()

# let programName = paramStr(0)
# let arguments = commandLineParams()
# echo arguments[0].parseInt().primFac_pollardRho().max()

echo 600_851_475_143.int().primFac_pollardRho().max()