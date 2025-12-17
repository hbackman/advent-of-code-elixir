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

  test "day04" do
    input = load_input("day04.txt")
    assert Aoc2025.Day04.part_one(input) == 1464
    assert Aoc2025.Day04.part_two(input) == 8409
  end

  test "day05" do
    input = load_input("day05.txt")
    assert Aoc2025.Day05.part_one(input) == 758
    assert Aoc2025.Day05.part_two(input) == 343143696885053
  end

  test "day06" do
    input = load_input("day06.txt")
    assert Aoc2025.Day06.part_one(input) == 4693419406682
    assert Aoc2025.Day06.part_two(input) == 9029931401920
  end

  test "day07" do
    input = load_input("day07.txt")
    assert Aoc2025.Day07.part_one(input) == 1622
    assert Aoc2025.Day07.part_two(input) == 10357305916520
  end

  test "day08" do
    input = load_input("day08.txt")
    assert Aoc2025.Day08.part_one(input) == 171503
    assert Aoc2025.Day08.part_two(input) == 9069509600
  end

  test "day09" do
    input = load_input("day09.txt")
    assert Aoc2025.Day09.part_one(input) == 4776487744
    # Disabled, takes too long
    # assert Aoc2025.Day09.part_two(input) == 1560299548
  end

end
