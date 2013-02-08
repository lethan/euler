# If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

def sumOfXBelowY(x, y)
  y = y - 1
  tmp = y.div(x)
  return x*(tmp*tmp+tmp)/2
end

def sumOf3And5Below(x)
  threeSum = sumOfXBelowY(3, x)
  fiveSum = sumOfXBelowY(5, x)
  fifthteenSum = sumOfXBelowY(15, x)
  return threeSum + fiveSum - fifthteenSum
end

puts sumOf3And5Below(1000)

# Tidskomplexitet af løsning O(1)