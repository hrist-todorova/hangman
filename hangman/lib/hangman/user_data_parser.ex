defmodule Hangman.Users.Parser do
  @data_file_path "data/user_data.txt"

  @moduledoc """
    This module reads saved information about all users and returns it to the Genserver when needed
  """

 @doc """
    Returns array of elements of type `Player`
  """
  def parse_data do
    data = File.read!(@data_file_path) |> String.split("\r")
    Enum.map(data, fn(x) -> Player.login(x) end)
  end

  def add_player(name, password) do
    {:ok, file} = File.open(@data_file_path, [:write, :append])
    IO.write file, "#{name} #{password} 0 0 \r"
    File.close(file)
  end

end