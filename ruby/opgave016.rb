# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

# What is the sum of the digits of the number 2^1000?

power = 2**1000

result = 0

begin
  result += power % 10
  power = power / 10
end while power>0

puts result