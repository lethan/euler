defmodule ProjectEuler.Problem89 do
  require IEx
  @moduledoc """
  For a number written in Roman numerals to be considered valid there are basic rules which must be followed.
  Even though the rules allow some numbers to be expressed in more than one way there is always a "best" way of writing a particular number.

  For example, it would appear that there are at least six ways of writing the number sixteen:

  IIIIIIIIIIIIIIII
  VIIIIIIIIIII
  VVIIIIII
  XIIIIII
  VVVI
  XVI

  However, according to the rules only XIIIIII and XVI are valid, and the last example is considered to be the most efficient,
  as it uses the least number of numerals.

  The 11K text file, roman.txt, contains one thousand numbers written in valid, but not necessarily minimal,
  Roman numerals; see About... Roman Numerals for the definitive rules for this problem.

  Find the number of characters saved by writing each of these in their minimal form.

  Note: You can assume that all the Roman numerals in the file contain no more than four consecutive identical units.
  """

  @roman_values [{"M", 1000}, {"CM", 900}, {"D", 500}, {"CD", 400}, {"C", 100}, {"XC", 90}, {"L", 50}, {"XL", 40}, {"X", 10}, {"IX", 9}, {"V", 5}, {"IV", 4}, {"I", 1}]

  defp string_to_value(string) do
    Enum.find(@roman_values, fn {roman, _} -> string == roman end)
  end

  def value_of_roman_numerals(""), do: 0
  def value_of_roman_numerals(roman) do
    case String.slice(roman, 0..1) |> string_to_value do
      {_, value} ->
        value + value_of_roman_numerals(String.slice(roman, 2..-1))
      _ ->
        {_, value} = string_to_value(String.first(roman))
        value + value_of_roman_numerals(String.slice(roman, 1..-1))
    end
  end

  def number_to_roman(0), do: ""
  def number_to_roman(number) do
    {roman, value} = @roman_values
    |> Enum.find(fn {_, value} -> number >= value end)

    roman <> number_to_roman(number - value)
  end

  def saved_chars(roman) do
    roman
    |> value_of_roman_numerals
    |> number_to_roman
    |> String.length
    |> (fn length -> String.length(roman) - length end).()
  end

  def saving_in_file(file) do
    {:ok, content} = File.read(file)

    content
    |> String.split("\n", trim: true)
    |> Enum.map(&saved_chars/1)
    |> Enum.sum
  end
end

ProjectEuler.Problem89.saving_in_file("p089_roman.txt")
|> IO.puts
