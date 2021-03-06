# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.

require 'prime'

primes = Prime.take_while do |p|
  p <= 2000000
end
puts primes.inject(:+)
