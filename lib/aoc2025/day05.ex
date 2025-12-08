defmodule Aoc2025.Day05 do

  defp parse(input) do
    [ranges, ingredients] = input
      |> Util.string_split_lines(2)

    ranges = ranges
      |> Util.string_split_lines()
      |> Enum.map(& String.split(&1, "-"))
      |> Enum.map(& Util.list_int_parse/1)
      |> Enum.map(fn [a, b] -> Range.new(a, b) end)

    ingredients = ingredients
      |> Util.string_split_lines()
      |> Util.list_int_parse()

    {ranges, ingredients}
  end

  defp fresh?(ranges, ingredient) do
    Enum.any?(ranges, fn range ->
      if ingredient in range, do: true, else: false
    end)
  end

  defp merge_ranges(ranges) do
    ranges
      |> Enum.sort_by(& &1.first)
      |> Enum.reduce([], fn range, acc ->
        case acc do
          [] ->
            [range]

          [last_range | rest] ->
            if range.first <= last_range.last + 1 do
              # Overlapping
              merged = last_range.first..max(last_range.last, range.last)//1
              [merged | rest]
            else
              # No overlap
              [range, last_range | rest]
            end
        end
      end)
      |> Enum.reverse()
  end

  def part_one(input) do
    {ranges, items} = parse(input)

    items
      |> Enum.filter(& fresh?(ranges, &1))
      |> Enum.count()
  end

  def part_two(input) do
    {ranges, _items} = parse(input)

    ranges
      |> merge_ranges()
      |> Enum.map(&Range.size(&1))
      |> Enum.sum()
  end

end
