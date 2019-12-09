# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

# How many such routes are there through a 20×20 grid?

edges = 20
routes = (edges * 2).downto(1).inject(:*) / (edges.downto(1).inject(:*)**2)

puts routes
