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
    Hangman.Users.register(name, password)
  end

  def get_user(name) do   
    Hangman.Users.get_user(name)
  end


  
  





  
end
