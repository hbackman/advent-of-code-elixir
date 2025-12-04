defmodule Aoc2025.Day04 do

  defp neighbors({x, y}) do
    [
      {x-1, y-1},
      {x-1, y+0},
      {x-1, y+1},
      {x+1, y-1},
      {x+1, y+0},
      {x+1, y+1},
      {x+0, y-1},
      {x+0, y+1},
    ]
  end

  defp find_removable(map) do
    p = Matrix.filter(map, & &1 == "@")

    Enum.filter(p, fn p ->
      neighbors(p)
        |> Enum.filter(& Matrix.inside?(map, &1))
        |> Enum.filter(& Matrix.get(map, &1) == "@")
        |> Enum.count()
        < 4
    end)
  end

  defp remove(map, removed \\ 0) do
    removable = find_removable(map)

    if Enum.count(removable) == 0 do
      removed
    else
      map = Enum.reduce(removable, map, fn p, m ->
        Matrix.put(m, p, ".")
      end)

      remove(map, removed + Enum.count(removable))
    end
  end

  def part_one(input) do
    input
      |> Matrix.from()
      |> find_removable()
      |> Enum.count()
  end

  def part_two(input) do
    input
      |> Matrix.from()
      |> remove()
  end

end
