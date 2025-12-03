defmodule Aoc2025.Day02 do

  defp parse(input) do
    input
      |> String.replace("\n", "")
      |> String.split(",", trim: true)
      |> Enum.map(fn range ->
        [r1, r2] = range
          |> String.split("-", trim: true)
          |> Util.list_int_parse()
        Range.new(r1, r2)
      end)
  end

  def part_one(input) do
    input
      |> parse()
      |> Enum.map(fn range ->
        Enum.filter(range, fn id ->
          id = Integer.to_string(id)
          {p1, p2} = String.split_at(id, div(String.length(id), 2))
          p1 == p2
        end)
      end)
      |> List.flatten()
      |> Enum.sum()
  end

  def invalid_id?(id) when is_number(id), do: invalid_id?(Integer.to_string(id))
  def invalid_id?(id) when is_binary(id) do
    length = String.length(id)

    if length < 2 do
      false
    else
      Enum.any?(1..(div(length, 2)), fn pattern_length ->
        if rem(length, pattern_length) == 0 do
          pattern = String.slice(id, 0, pattern_length)
          repetitions = div(length, pattern_length)

          repetitions >= 2 and String.duplicate(pattern, repetitions) == id
        else
          false
        end
      end)
    end
  end

  def part_two(input) do
    input
      |> parse()
      |> Enum.map(fn range -> Enum.filter(range, &invalid_id?/1) end)
      |> List.flatten()
      |> Enum.sum()
  end

end
