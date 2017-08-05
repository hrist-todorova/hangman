defmodule Hangman.Users.Parser do
  @data_file_path "data/user_data.txt"

  @moduledoc """
    This module reads and writes information about the users
  """

  @doc """
    Returns array of elements of type `Player`
  """
  def parse_data do
    data = File.read!(@data_file_path) |> String.split("\r")
    Enum.map(data, fn(x) -> Player.login(x) end)
  end

  @doc """
    Inserts a new player in the database
  """

  def add_player(name, password) do
    {:ok, file} = File.open(@data_file_path, [:write, :append])
    IO.write file, "#{name} #{password} 0 0 \r"
    File.close(file)
  end

end