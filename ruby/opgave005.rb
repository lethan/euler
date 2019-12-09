# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

require 'prime'

def smallest(number)
  number = number.abs
  primes = Prime.take_while do |p|
    p <= number
  end
  primes.reverse!

  factors = Array.new(primes.length).fill(0)

  (1 .. number).each do |value|
    thisfac = Array.new(primes.length).fill(0)

    primes.each_with_index do |prime, index|
      while value % prime == 0
        value /= prime
        thisfac[index] += 1
      end
    end

    thisfac.each_with_index do |num, index|
      factors[index] = num if num > factors[index]
    end
  end
  result = 1
  primes.each_with_index do |prime, index|
    result *= prime ** factors[index]
  end

  result
end

puts smallest(20)
