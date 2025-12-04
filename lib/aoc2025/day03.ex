defmodule Aoc2025.Day03 do

  defp parse(input) do
    input
      |> Util.string_split_lines()
      |> Enum.map(fn l -> Util.string_to_int_list(l, "") end)
  end

  defp next(bank, size, result \\ [])
  defp next(bank, size, result) do
    if Enum.count(result) == size do
      result
        |> Enum.reverse()
        |> Enum.join()
        |> String.to_integer()
    else
      m = bank
        |> Enum.drop(- (size - 1 - Enum.count(result)))
        |> Enum.max()

      r = Enum.drop(bank, Enum.find_index(bank, & &1 == m) + 1)

      next(r, size, [m | result])
    end
  end

  def part_one(input) do
    input
      |> parse()
      |> Enum.map(fn bank -> next(bank, 2) end)
      |> Enum.sum()
  end

  def part_two(input) do
    input
      |> parse()
      |> Enum.map(fn bank -> next(bank, 12) end)
      |> Enum.sum()
  end

end
