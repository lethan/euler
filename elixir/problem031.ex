defmodule ProjectEuler.Problem31 do
  @moduledoc """
  In the United Kingdom the currency is made up of pound (£) and pence (p). There are eight coins in general circulation:

  1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).
  It is possible to make £2 in the following way:

  1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
  How many different ways can £2 be made using any number of coins?
  """

  def coin_permulations([], _, _), do: 0
  def coin_permulations(_, target, current_sum) when current_sum > target, do: 0
  def coin_permulations(_, target, current_sum) when target == current_sum, do: 1
  def coin_permulations([coin | other_coins] = coins, target, current_sum) do
    coin_permulations(coins, target, current_sum + coin) + coin_permulations(other_coins, target, current_sum)
  end
end

IO.puts(ProjectEuler.Problem31.coin_permulations([200, 100, 50, 20, 10, 5, 2, 1], 200, 0))
