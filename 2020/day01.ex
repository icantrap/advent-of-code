defmodule Day01 do
  def part1 do
    [{x, y} | _] = for x <- expense_report(), y <- expense_report(), x + y == 2020, do: {x, y}

    x*y
  end

  def part2 do
    [{x, y, z} | _] = for x <- expense_report(), y <- expense_report(), z <- expense_report(), x + y + z == 2020, do: {x, y, z}
    x*y*z
  end

  defp expense_report do
    File.read!('day01.dat')
      |> String.split
      |> Enum.map(&String.to_integer/1)
  end
end

IO.puts "Part 1. Product = #{Day01.part1}"
IO.puts "Part 2. Product = #{Day01.part2}"
