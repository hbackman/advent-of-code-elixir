defmodule Aoc2025Test do
  use ExUnit.Case

  @moduletag timeout: :infinity

  defp load_input(input) do
    [:code.priv_dir(:aoc), "aoc2025", input]
      |> Path.join()
      |> File.read!()
  end

  test "day01" do
    input = load_input("day01.txt")
    assert Aoc2025.Day01.part_one(input) == 1066
    assert Aoc2025.Day01.part_two(input) == 6223
  end

  test "day02" do
    input = load_input("day02.txt")
    assert Aoc2025.Day02.part_one(input) == 30608905813
    assert Aoc2025.Day02.part_two(input) == 31898925685
  end

  test "day03" do
    input = load_input("day03.txt")
    assert Aoc2025.Day03.part_one(input) == 17281
    assert Aoc2025.Day03.part_two(input) == 171388730430281
  end

end
