defmodule Data.Word.Queries do
  import Ecto.Query

  @moduledoc """
  This module provides queries which access and change information about the words in the game.
  """

  @doc """
  This function adds a word in a room. It returns :error if this word is already in the room and :ok otherwise.
  """
  def add_word(word, username, roomname) do
    exists = "words"
             |> where([u], u.word == ^word and u.roomname == ^roomname)
             |> select([:word])
             |> Data.Repo.all
    if exists == [] do
      Data.Repo.insert(%Data.Word{word: "#{word}", username: "#{username}", roomname: "#{roomname}"})
      :ok
    else
      :error
    end
  end

  @doc """
  This function returns a map %{word: new_word} where new_word is a word added by another user or it is "hangman" if there isn't any words by other players.
  """
  def get_a_word(not_from_user, roomname) do
    words = "words"
            |> where([u], u.username != ^not_from_user and u.roomname == ^roomname)
            |> select([:word]) 
            |> Data.Repo.all
    
    if words == [] do
      %{word: "hangman"} 
    else
      Enum.random(words)
    end
  end

end