# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which, a^2 + b^2 = c^2
# For example,3^2 +4^2 =9+16=25=5^2.
# There exists exactly one Pythagorean triplet for which a + b + c = 1000. Find the product abc.

from future import lc, `[]` #list comprehension

let pyth = lc[(a,b,c) | (a<-1..1000,
                   b<-a..1000, #avoid duplicate
                   c<-b..1000, #c is superior to a and b
                   a*a + b*b == c*c,
                   a+b+c == 1000),
                   tuple[a,b,c: int]]

echo pyth[0].a * pyth[0].b * pyth[0].c