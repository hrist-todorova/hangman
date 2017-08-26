defmodule Data.Word.Queries do
  import Ecto.Query

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