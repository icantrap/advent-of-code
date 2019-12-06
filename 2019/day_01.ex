defmodule Day01 do
  def part1 do
    masses()
      |> Enum.map(&Day01.fuel_needed/1)
      |> Enum.sum
  end

  def part2 do
    masses()
      |> Enum.map(&Day01.actual_fuel_needed/1)
      |> Enum.sum
  end

  defp masses do
    File.read!('day_01.txt')
      |> String.split
      |> Enum.map(&String.to_integer/1)
  end

  def fuel_needed(mass) do
    [div(mass, 3) - 2, 0]
      |> Enum.max
  end

  def actual_fuel_needed(mass) do
    actual_fuel_needed(mass, 0)
  end
  defp actual_fuel_needed(mass, acc) do
    if (fuel = fuel_needed(mass)) > 0 do
      actual_fuel_needed(fuel, acc + fuel)
    else
      acc
    end
  end
end

IO.puts "Part 1. Sum = #{Day01.part1}"
IO.puts "Part 2. Sum = #{Day01.part2}"

# completed output
# Part 1. Sum = 3318632
# Part 2. Sum = 4975084
