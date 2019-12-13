# frozen_string_literal: true

require 'prime'

max_number = 28_123

abundant_numbers = []

def abundant_number?(number)
  return false if number == 1
  primes = number.prime_division.flat_map { |prime, freq| [prime] * freq }
  (1...primes.size).each_with_object([1]) do |n, res|
    primes.combination(n).map{|combi| res << combi.inject(:*)}
  end.flatten.uniq.sum > number
end

(1..max_number).each do |number|
  abundant_numbers << number if abundant_number?(number)
end

abundant_sum_numbers = Hash.new(false)
abundant_numbers.each_with_index do |number1, index1|
  (index1..abundant_numbers.size - 1).each do |index2|
    abundant_sum_numbers[number1 + abundant_numbers[index2]] = true
  end
end

sum_non_abundant = 0
(1..max_number).each do |number|
  sum_non_abundant += number unless abundant_sum_numbers[number]
end
puts sum_non_abundant
