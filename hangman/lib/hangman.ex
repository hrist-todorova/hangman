defmodule Hangman do
  @moduledoc """
  Documentation for Hangman.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Hangman.hello
      :world

  """
  def hello do
    :world
  end

  def register(name, password) do
    :ets.insert(:users, {name, Player.new(name, password)})
  end

  def user_info(name) do
    :ets.lookup(:users, name)
  end

  
  





  
end
