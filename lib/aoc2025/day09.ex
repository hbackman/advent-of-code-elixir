defmodule Aoc2025.Day09 do

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

  defp area({x1, y1}, {x2, y2}) do
    (abs(x2 - x1) + 1) * (abs(y2 - y1) + 1)
  end

  def part_one(input) do
    input
      |> parse()
      |> generate_pairs()
      |> Enum.map(fn {p1, p2} -> area(p1, p2) end)
      |> Enum.max()
  end

  defp valid?({x1, y1}, {x2, y2}, vertices, cache) do
    min_x = min(x1, x2)
    max_x = max(x1, x2)
    min_y = min(y1, y2)
    max_y = max(y1, y2)

    # Check all points on the perimeter only
    perimeter_points =
      (for x <- min_x..max_x, do: {x, min_y}) ++  # Top edge
      (for x <- min_x..max_x, do: {x, max_y}) ++  # Bottom edge
      (for y <- (min_y + 1)..(max_y - 1), do: {min_x, y}) ++  # Left edge
      (for y <- (min_y + 1)..(max_y - 1), do: {max_x, y})     # Right edge

    Enum.reduce_while(perimeter_points, {true, cache}, fn point, {_valid, current_cache} ->
      case Map.get(current_cache, point) do
        nil ->
          result = point_inside_or_on_polygon?(point, vertices)
          updated_cache = Map.put(current_cache, point, result)

          if result,
            do:   {:cont, {true, updated_cache}},
            else: {:halt, {false, updated_cache}}
        cached_result ->
          if cached_result,
            do: {:cont, {true, current_cache}},
          else: {:halt, {false, current_cache}}
      end
    end)
  end

  defp point_inside_or_on_polygon?({x, y}, vertices) do
    edges = Enum.zip(vertices, tl(vertices) ++ [hd(vertices)])

    # Check if on any edge
    on_edge = Enum.any?(edges, fn {{x1, y1}, {x2, y2}} ->
      (x1 == x2 and x == x1 and y >= min(y1, y2) and y <= max(y1, y2)) or
      (y1 == y2 and y == y1 and x >= min(x1, x2) and x <= max(x1, x2))
    end)

    # If on edge, return true; otherwise check if inside
    if on_edge do
      true
    else
      crossings = Enum.count(edges, fn {{x1, y1}, {x2, y2}} ->
        ((y1 > y) != (y2 > y)) and
        (x < (x2 - x1) * (y - y1) / (y2 - y1) + x1)
      end)

      rem(crossings, 2) == 1
    end
  end

  def part_two(input, debug \\ false) do
    coords = parse(input)

    pairs = generate_pairs(coords)
    total = length(pairs)

    pairs
      |> Enum.map(fn {p1, p2} -> {p1, p2, area(p1, p2)} end)
      |> Enum.sort_by(fn {_, _, d} -> d end, :desc)
      |> Enum.with_index()
      |> Enum.reduce_while(%{}, fn {{p1, p2, d}, idx}, cache ->
        if rem(idx, 100) == 0 && debug do
          IO.write("\rProgress: #{idx}/#{total} (#{Float.round(idx / total * 100, 1)}%) - Cache: #{map_size(cache)}")
        end

        {result, updated_cache} = valid?(p1, p2, coords, cache)

        if result do
          {:halt, {p1, p2, d}}
        else
          {:cont, updated_cache}
        end
      end)
      |> elem(2)
  end

end
