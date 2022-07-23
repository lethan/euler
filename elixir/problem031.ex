defmodule ProjectEuler.Problem31 do
  @moduledoc """
  In the United Kingdom the currency is made up of pound (£) and pence (p). There are eight coins in general circulation:

  1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).
  It is possible to make £2 in the following way:

  1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
  How many different ways can £2 be made using any number of coins?
  """

  def coin_permulations(coins, amount)
  def coin_permulations(_, 0), do: 1
  def coin_permulations(_, amount) when amount < 0, do: 0
  def coin_permulations([], _), do: 0

  def coin_permulations([coin | other_coins] = coins, amount) do
    coin_permulations(coins, amount - coin) + coin_permulations(other_coins, amount)
  end
end

IO.puts(ProjectEuler.Problem31.coin_permulations([200, 100, 50, 20, 10, 5, 2, 1], 200))
