defmodule Aoc2025.Day10 do

  defp parse(input) do
    ~r/\[([\.\#]*)\] (.*) {([0-9,]*)}/
      |> Regex.scan(input, capture: :all_but_first)
      |> Enum.map(fn [pattern, parens, curly] ->
        parens = ~r/\(([0-9,]+)\)/
          |> Regex.scan(parens, capture: :all_but_first)
          |> List.flatten()
          |> Enum.map(&Util.string_to_int_list(&1, ","))

        curly = Util.string_to_int_list(curly, ",")

        {pattern, parens, curly}
      end)
  end

  defp press(state, button) do
    Enum.reduce(button, state, fn position, state ->
      state
        |> String.graphemes()
        |> List.update_at(position, fn
          "." -> "#"
          "#" -> "."
        end)
        |> Enum.join()
    end)
  end

  defp solve({state, buttons, _}) do
    initial = String.duplicate(".", String.length(state))
    {result, _cache} = do_solve(initial, state, buttons, 0, %{})
    result
  end

  defp do_solve(state, target, buttons, pressed, cache) do
    cache_key = {state, pressed}
    cond do
      state == target ->
        {0, cache}

      pressed > String.length(state) ->
        {10_000_000_000_000, cache}

      Map.has_key?(cache, cache_key) ->
        {cache[cache_key], cache}

      true ->
        {best, cache} =
          Enum.reduce(buttons, {10_000_000_000_000, cache}, fn button, {best, cache} ->
            new_state = press(state, button)
            {result, cache} = do_solve(new_state, target, buttons, pressed + 1, cache)
            {min(best, 1 + result), cache}
          end)

        {best, Map.put(cache, cache_key, best)}
    end
  end

  def part_one(input) do
    input
      |> parse()
      |> Enum.map(&solve/1)
      |> Enum.sum()
  end

  def part_two(input) do
  end

end
