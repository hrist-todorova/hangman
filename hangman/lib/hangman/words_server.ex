defmodule Hangman.Words do
  use GenServer

  @moduledoc """
  This is the server containing the words
  """

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :words)
  end

  @doc """
  Returns :ok after adding the new word in the list of words
  """

  def add_word(word) when is_bitstring(word) do
    GenServer.cast(:words, {:add, word})
  end

  @doc """
  Return a string which is a random word from list of words
  """

  def get_a_word do
    GenServer.call(:words, :get_word)   
  end

  def init(_) do
    {:ok, Hangman.Words.Parser.parse_data}
  end

  def handle_cast({:add, word}, state) do
    if !Enum.member?(state, word) do
      Hangman.Words.Parser.add_word(word)
      {:noreply, [word | state]}
    else
      {:noreply, state}
    end
  end

  def handle_call(:get_word, _from, state) do
    {:reply, Enum.random(state), state}
  end

end
