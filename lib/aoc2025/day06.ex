defmodule Aoc2025.Day06 do

  defp parse_cephalopod(n, index \\ 0, output \\ []) do
    nn = n
      |> Enum.map(&String.at(&1, index))
      |> Enum.join()

    if nn != "" do
      parse_cephalopod(n, index + 1, [nn | output])
    else
      output
        |> Enum.reverse()
        |> Enum.chunk_by(& String.trim(&1) == "")
        |> Enum.reject(& Enum.count(&1) == 1)
        |> Enum.map(fn v ->
          Enum.map(v, fn vv ->
            vv
              |> String.trim()
              |> String.to_integer()
          end)
        end)
    end
  end

  def part_one(input) do
    input
      |> Util.string_split_lines()
      |> Enum.map(&String.split(&1, " ", trim: true))

      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)

      |> Enum.map(&Enum.reverse/1)
      |> Enum.map(fn [s | numbers] -> [s | Enum.map(numbers, &String.to_integer/1)] end)

      |> Enum.map(fn
        ["*" | n] -> Enum.product(n)
        ["+" | n] -> Enum.sum(n)
      end)
      |> Enum.sum()
  end

  def part_two(input) do
    lines = input
      |> String.split("\n", trim: true)

    o = lines
      |> List.last()
      |> String.split(" ", trim: true)

    n = lines
      |> Enum.drop(-1)
      |> parse_cephalopod()

    Enum.zip(o, n)
      |> Enum.map(fn
        {"*", n} -> Enum.product(n)
        {"+", n} -> Enum.sum(n)
      end)
      |> Enum.sum()
  end

end
