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
    #assert Aoc2025.Day01.part_one(input) == 1066
    assert Aoc2025.Day01.part_two(input) == nil
  end

end
