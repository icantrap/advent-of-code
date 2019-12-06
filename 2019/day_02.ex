defmodule Day02 do
  def part1 do
    intcode()
      |> List.replace_at(1, 12)
      |> List.replace_at(2, 2)
      |> execute()
  end

  def part2 do
    intcode = intcode()

    # could use reduce here, but reduce_while has pre-emptive halting
    Enum.reduce_while(0..99, nil, fn noun, _acc ->
      Enum.reduce_while(0..99, nil, fn verb, _acc ->
        intcode
          |> List.replace_at(1, noun)
          |> List.replace_at(2, verb)
          |> execute()
          |> case do
            19690720 -> {:halt, 100*noun + verb}
            _ -> {:cont, nil}
          end
      end)
      |> case do
        x when is_number(x) -> {:halt, x}
        _ -> {:cont, nil}
      end
    end)
  end

  defp intcode do
    File.read!('day_02.txt')
      |> parse_code
  end

  defp parse_code(input) do
    input
      |> String.trim
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
  end

  def execute(input) when is_binary(input) do
    input
      |> parse_code
      |> execute
  end
  def execute(input) do
    execute_at(input, 0)
      |> hd
  end

  defp execute_at(data, ptr) do
    case Enum.at(data, ptr) do
      1 -> do_add(data, ptr)
             |> execute_at(ptr+4)
      2 -> do_multiply(data, ptr)
             |> execute_at(ptr+4)
      99 -> data
    end
  end

  defp do_add(data, ptr) do
    first_pos = Enum.at(data, ptr+1)
    second_pos = Enum.at(data, ptr+2)
    third_pos = Enum.at(data, ptr+3)
    left = Enum.at(data, first_pos)
    right = Enum.at(data, second_pos)
    sum = left + right
    List.replace_at(data, third_pos, sum)
  end

  defp do_multiply(data, ptr) do
    first_pos = Enum.at(data, ptr+1)
    second_pos = Enum.at(data, ptr+2)
    third_pos = Enum.at(data, ptr+3)
    left = Enum.at(data, first_pos)
    right = Enum.at(data, second_pos)
    sum = left*right
    List.replace_at(data, third_pos, sum)
  end
end

IO.puts "Part 1. Output = #{Day02.part1}"
IO.puts "Part 2. Output = #{Day02.part2}"

# completed output
# Part 1. Output = 4945026
# Part 2. Output = 5296
