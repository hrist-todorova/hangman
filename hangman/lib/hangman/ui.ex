defmodule Hangman.UI do

  @moduledoc """
  This module provides all functions which will be available to a user
  """

  @doc """
  Register user in the game, returns new user object
  """

  def register(name, password) do
    Hangman.Users.register(name, password)
  end

  @doc """
  Logging in the game, returns user object which was previously created
  """

  def login(name, password) do
    Hangman.Users.login(name, password)
  end



  def add_word(new_word, user) do
    Hangman.Words.Queries.add_word(new_word, user)
  end

  def create_room(name) when is_bitstring(name) do
    Hangman.Rooms.add_new_room(name)
  end

  def enter_room(player, name) when is_bitstring(name) do
    Hangman.Rooms.insert_a_player(player, name)
  end

  def start_game(player, room) do
    Game.new(Hangman.Words.Queries.get_a_word(player.name)[:word], player, room.name)
  end

end