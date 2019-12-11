defmodule Day04 do
  def execute do
    [min, max] = "193651-649729"
                   |> String.split("-")
                   |> Enum.map(&String.to_integer/1)

    Enum.filter(min..max, &password_valid?/1)
      |> length
  end

  def password_valid?(password) when is_integer(password) do
    password
      |> Integer.to_string
      |> password_valid?
  end
  def password_valid?(password) when is_binary(password) do
    two_adjacent_digits?(password) && increasing_digit_order?(password)
  end

  defp two_adjacent_digits?(password) do
    String.match?(password, ~r/(\d)\1/)
  end

  defp increasing_digit_order?(password) do
    to_charlist(password) == password
                               |> to_charlist
                               |> Enum.sort
  end
end

IO.puts "Part 1. Answer=#{Day04.execute}"
