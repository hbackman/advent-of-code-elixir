defmodule Aoc2025.Day01 do

  defp parse(input) do
    input
      |> Util.string_split_lines()
      |> Enum.map(fn instruction ->
        {dir, amt} = String.next_grapheme(instruction)
        amt = String.to_integer(amt)
        {dir, amt}
      end)
  end

  def wrap(n, max \\ 100) do
    rem(rem(n, max) + max, max)
  end

  def count_zeroes(pos, {_dir, 0}, zeroes), do: {pos, zeroes}
  def count_zeroes(pos, {dir, amt}, zeroes) do
    pos = case dir do
      "R" -> wrap(pos + 1)
      "L" -> wrap(pos - 1)
    end

    count_zeroes(pos, {dir, amt-1}, zeroes + (if pos == 0, do: 1, else: 0))
  end

  def part_one(input) do
    input
      |> parse()
      |> Enum.reduce({50, 0}, fn {dir, amt}, {pos, zero} ->
       pos = case dir do
         "L" -> wrap(pos - amt)
         "R" -> wrap(pos + amt)
       end

       if pos == 0, do: {pos, zero + 1}, else: {pos, zero}
      end)
      |> elem(1)
  end

  def part_two(input) do
    input
      |> parse()
      |> Enum.reduce({50, 0}, fn {dir, amt}, {pos, zero} ->
        {npos, wrap} = count_zeroes(pos, {dir, amt}, 0)
        {npos, zero + wrap}
      end)
      |> elem(1)
  end

end
