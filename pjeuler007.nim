# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# What is the 10 001st prime number?

from lib_euler_primes import primeSieve
from os import commandLineParams
from strutils import parseInt
from math import ln

let arguments = commandLineParams()

#nth prime number is about n * log (n), * 2 for error
let r = (10001 * ln(10001.float32).int shl 1).primeSieve()
echo r[10000] #prime 1 is in pos 0, 10001 in pos 10000