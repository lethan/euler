# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

hundred = 7

thousand = 8

og = 3

def numToLength number
  case number
  when 0
    0
  when 1
    3
  when 2
    3
  when 3
    5
  when 4
    4
  when 5
    4
  when 6
    3
  when 7
    5
  when 8
    5
  when 9
    4
  when 10
    3
  when 11
    6
  when 12
    6
  when 13
    8
  when 14
    8
  when 15
    7
  when 16
    7
  when 17
    9
  when 18
    8
  when 19
    8
  when 20..39
    6 + numToLength(number % 10)
  when 40..69
    5 + numToLength(number % 10)
  when 70..79
    7 + numToLength(number % 10)
  when 80..99
    6 + numToLength(number % 10)
  when 1000
    8 + numToLength(1)
  else
    numToLength(number / 100) + 7 + ((number%100 > 0) ? 3 + numToLength(number%100) : 0)
  end
end

sum = 0
(1..1000).each do |val|
  sum += numToLength val
end
puts "sdf: #{sum}"