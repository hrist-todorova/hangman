defmodule Hangman.Users.Parser do
  @data_file_path "data/user_data.txt"

  @moduledoc """
    This module reads saved information about all users and returns it to the Genserver when needed
  """

 @doc """
    Returns array of elements of type `Player`
  """
  def parse_data do
    data = File.read!(@data_file_path) |> String.split("\n")
    Enum.map(data, fn(x) -> String.trim(x, "\r") |> Player.login end)
  end

end