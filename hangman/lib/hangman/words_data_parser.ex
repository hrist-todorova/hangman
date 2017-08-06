defmodule Hangman.Words.Parser do
  @data_file_path "data/words.txt"

  @moduledoc """
  This module gets and adds words in the game
  """

  @doc """
  Returns array of all words in the word list
  """
  def parse_data do
    [_ | tail] = File.read!(@data_file_path) |> String.split("\r")
    tail
  end

  @doc """
  Adds new word to the words list
  """

  def add_word(word) do
    {:ok, file} = File.open(@data_file_path, [:write, :append])
    IO.write file, "\r#{word}"
    File.close(file)
  end

end