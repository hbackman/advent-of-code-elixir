defmodule Aoc2025.Day08 do

  defp parse(input) do
    input
      |> Util.string_split_lines()
      |> Enum.map(&Util.string_to_int_list(&1, ","))
      |> Enum.map(&List.to_tuple/1)
  end

  defp generate_pairs(coords) do
    for {p1, i} <- Enum.with_index(coords),
        {p2, j} <- Enum.with_index(coords),
        i < j do
      {p1, p2}
    end
  end

  defp distance({x1, y1, z1}, {x2, y2, z2}) do
    :math.sqrt(
      :math.pow(x2 - x1, 2) +
      :math.pow(y2 - y1, 2) +
      :math.pow(z2 - z1, 2)
    )
  end

  defp merge_until_single_circuit(pairs, initial_groups) do
    Enum.reduce_while(pairs, {initial_groups, nil}, fn [p1, p2] = pair, {groups, _} ->
      {matching, others} = Enum.split_with(groups, fn group ->
        p1 in group or p2 in group
      end)

      # If both points are already in the same group, skip
      if length(matching) <= 1 do
        {:cont, {groups, nil}}
      else
        # Merge the groups
        merged = Enum.uniq(List.flatten(matching))
        new_groups = [merged | others]

        # Check if all junction boxes are now in a single circuit
        if length(new_groups) == 1 do
          {:halt, {new_groups, pair}}
        else
          {:cont, {new_groups, nil}}
        end
      end
    end)
  end

  def part_one(input) do
    coords = parse(input)
    groups = Enum.map(coords, fn coord -> [coord] end)

    pairs = coords
      |> generate_pairs()
      |> Enum.map(fn {p1, p2} -> {p1, p2, distance(p1, p2)} end)
      |> Enum.sort_by(fn {_, _, d} -> d end)
      |> Enum.take(1000)
      |> Enum.map(fn {p1, p2, _} -> [p1, p2] end)

    {groups, _completing_pair} = merge_until_single_circuit(pairs, groups)

    groups
      # Sort by the size of the junction boxes
      |> Enum.map(&Enum.count/1)
      |> Enum.sort(:desc)
      |> Enum.take(3)
      |> Enum.product()
  end

  def part_two(input) do
    coords = parse(input)
    groups = Enum.map(coords, fn coord -> [coord] end)

    pairs = coords
      |> generate_pairs()
      |> Enum.map(fn {p1, p2} -> {p1, p2, distance(p1, p2)} end)
      |> Enum.sort_by(fn {_, _, d} -> d end)
      |> Enum.map(fn {p1, p2, _} -> [p1, p2] end)

    {_groups, [{x1, _, _}, {x2, _, _}]} = merge_until_single_circuit(pairs, groups)

    x1 * x2
  end

end
