# Solving Project Euler problems with Nim

Project Euler is a website that publish hundreds of mathematics oriented problems.
It's an excellent website to learn a new language with a numeric focus. (You won't learn web development ;) )

[Project Euler](https://projecteuler.net/)

- Pb 1: Find the sum of all the multiples of 3 or 5 below 1000.

  *Solved with list comprehension*
- Pb 2: Sum of even number from Fibonacci numver < 4000000.

  *Solved with functional programming (takeWhile, filter)*
- Pb 3: Largest prime factor of the number 600851475143.

  *Solved by creating a prime factorization method.*
- Pb 4: Find the largest palindrome made from the product of two 3-digit numbers (same number even if read backward).

  *Solved with list comprehension and implementing unfold, haskell-style.*
- Pb 5: What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20.

  *Solved by folding a least common multiple function.*
- Pb 6: Difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

  *Solved with map*
- Pb 7: What is the 10 001st prime number?

  *Solved by implementing a prime sieve with a BitVector type to optimize CPU cache. I benchmarked it against primegen, primesieve and a lot of prime sieve on Rosetta Stone. It's very very fast and memory efficient and less than 50lines, comment included. Only thing faster is the Nim inline implementation on Rosetta Code.*
- Pb 8: Find the thirteen adjacent digits in the given 1000-digit number that have the greatest product. What is the value of this product?

  *Solved by creating a sliding window that returns an iterator containing the product of the 13 numbers. Then fold to get the maximum.*
  
- Pb 9: A Pythagorean triplet is a set of three natural numbers, a < b < c, for which, a^2 + b^2 = c^2. There exists exactly one Pythagorean triplet for which a + b + c = 1000. Find the product abc.

  *Solved using list comprehension*

- Pb 10: Find the sum of all the primes below two million.

  *Solved using the primesieve from Pb7*