# The following iterative sequence is defined for the set of positive integers:

# n -> n/2 (n is even)
# n -> 3n + 1 (n is odd)

# Using the rule above and starting with 13, we generate the following sequence:

# 13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

# Which starting number, under one million, produces the longest chain?

# NOTE: Once the chain starts the terms are allowed to go above one million.

seq = {1 => 1}

def calc_chain(val, seq)
  if seq[val]
    return seq[val]
  else
    if val.even?
      seq[val] = calc_chain(val/2, seq) + 1
    else
      seq[val] = calc_chain(val*3+1, seq) + 1
    end
  end
end

(1..1000000).each do |val|
  calc_chain(val, seq)
end

start = maximum = 0 

seq.each do |key, value|
	start, maximum = key, value if value > maximum
end

puts "Start value: " + start.to_s + ", steps: " + maximum.to_s