defmodule Data.Room.Queries do
  import Ecto.Query 
  
  def add_user_to_room(roomname, username) do
    Data.Repo.insert(%Data.Room{roomname: "#{roomname}" ,username: "#{username}", wins: 0})
  end

  def get_all_room_names do
    "rooms"
    |> select([:roomname])
    |> Data.Repo.all
    |> Enum.uniq
    |> Enum.map(fn(x) -> x.roomname end)
  end

end