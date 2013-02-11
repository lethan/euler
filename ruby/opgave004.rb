# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

max = 0
100.upto(999) { |a|
  a.upto(999) { |b|
    prod = a * b
    max = [max, prod].max if prod.to_s == prod.to_s.reverse
  }
}
puts max