defmodule Aoc2025.Day07 do

  defp solve(matrix, row, splits \\ 0) do
    if row < matrix.h - 1 do
      lines = Matrix.filter(matrix, & &1 == "|")
        |> Enum.filter(fn {_x, y} -> y == row end)

      {matrix, new_splits} = Enum.reduce(lines, {matrix, 0}, fn {x, y}, {m, s} ->
        if Matrix.get(m, {x, y+1}) == "^" do
          m = m
            |> Matrix.put(x-1, y+1, "|")
            |> Matrix.put(x+1, y+1, "|")
          {m, s + 1}
        else
          {Matrix.put(m, x, y+1, "|"), s}
        end
      end)

      solve(matrix, row + 1, splits + new_splits)
    else
      splits
    end
  end

  defp count_paths(matrix, {x, y}) do
    paths(matrix, {x, y}) |> elem(0)
  end

  defp paths(matrix, {x, y}, cache \\ %{}) do
    case Map.get(cache, {x, y}) do
      nil ->
        result = case Matrix.get(matrix, {x, y+1}) do
          "." ->
            paths(matrix, {x, y+1}, cache)
          "^" ->
            {l, c1} = paths(matrix, {x-1, y+1}, cache)
            {r, c2} = paths(matrix, {x+1, y+1}, c1)
            {l + r, c2}
          _ ->
            {1, cache}
        end

        {val, new_cache} = result
        {val, Map.put(new_cache, {x, y}, val)}

      cached ->
        {cached, cache}
    end
  end

  def part_one(input) do
    m = Matrix.from(input)
    p = Matrix.find(m, & &1 == "S")

    {x, y} = p

    m = Matrix.put(m, x, y+1, "|")

    solve(m, y+1)
  end

  def part_two(input) do
    m = Matrix.from(input)
    p = Matrix.find(m, & &1 == "S")

    count_paths(m, p)
  end

end
