# frozen_string_literal: true

def reciprocal_cycle(number)
  remainders = {}
  remainder = 1
  digit = 0
  cycle = 0
  until remainder.zero?
    remainder %= number
    if remainders[remainder]
      cycle = digit - remainders[remainder]
      remainder = 0
    end
    remainders[remainder] = digit
    remainder *= 10
    digit += 1
  end
  cycle
end

max_cycle = 0
cycle_number = 0
(1..999).each do |n|
  cycle = reciprocal_cycle(n)
  if cycle > max_cycle
    max_cycle = cycle
    cycle_number = n
  end
end
puts cycle_number
