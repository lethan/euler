# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

# Evaluate the sum of all the amicable numbers under 10000.

require 'prime'

def proper_divisors(number)
  return [] if number == 1

  primes = number.prime_division.flat_map { |prime, freq| [prime] * freq }
  (1...primes.size).each_with_object([1]) do |n, res|
    primes.combination(n).map { |combi| res << combi.inject(:*) }
  end.flatten.uniq
end

amicable_sum = 0

divisor_sum = {}

(1..10_000).each do |n|
  sum = proper_divisors(n).sum
  amicable_sum += n + sum if divisor_sum[sum] == n
  divisor_sum[n] = sum
end

puts amicable_sum
