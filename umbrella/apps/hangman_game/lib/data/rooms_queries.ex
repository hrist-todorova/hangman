defmodule Data.Room.Queries do
  import Ecto.Query 
  
  def add_user_to_room(roomname, username) do
    #fix it
    Data.Repo.insert(%Data.Room{roomname: "#{roomname}" ,username: "#{username}", wins: 0})
  end

  def login(roomname, username) do
    wins = "rooms"
           |> where([u], u.roomname == ^roomname and u.username == ^username)
           |> select([:wins])
           |> Data.Repo.all
  end

  def exists_room?(roomname) do
    [] != "rooms"
          |> where([u], u.roomname == ^roomname)
          |> select([:roomname])
          |> Data.Repo.all
  end

  def get_all_room_names do
    "rooms"
    |> select([:roomname])
    |> Data.Repo.all
    |> Enum.uniq
    |> Enum.map(fn(x) -> x.roomname end)
  end

end