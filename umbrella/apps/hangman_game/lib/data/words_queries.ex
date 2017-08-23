defmodule Data.Word.Queries do
  import Ecto.Query

  def add_word(word, username, roomname) do
    Data.Repo.insert(%Data.Word{word: "#{word}", username: "#{username}", roomname: "#{roomname}"})
  end

  def get_a_word(not_from_user, roomname) do
    words = "words"
            |> where([u], u.username != ^not_from_user and u.roomname == ^roomname)
            |> select([:word]) 
            |> Data.Repo.all
    
    if words == [] do
      %{word: :error} #THIS MEANS THAT YOU ARE THE ONLY PLAYER IN THE ROOM BRUH
    else
      Enum.random(words)
    end
  end

end