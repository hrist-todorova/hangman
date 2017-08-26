defmodule Data.Room.Queries do
  import Ecto.Query 

  @moduledoc """
  This module provides queries which access and change information about the rooms in the game.
  """
  
  @doc """
  Add user to a room if he/she is not in there yet.
  """
  def add_user_to_room(roomname, username) do
    if Data.Repo.get_by(Data.Room, [roomname: "#{roomname}" ,username: "#{username}"]) == nil do
      Data.Repo.insert(%Data.Room{roomname: "#{roomname}" ,username: "#{username}", wins: 0})
    end
  end

  @doc """
  Increments the number of wins of this user in this room by one.
  """
  def add_win(username, roomname) do
    [%{wins: all_wins}] = "rooms"
                          |> where([u], u.username == ^username and u.roomname == ^roomname)
                          |> select([:wins]) 
                          |> Data.Repo.all
    all_wins = all_wins + 1

    from(u in Data.Room, where: u.username == ^username and u.roomname == ^roomname, update: [set: [wins: ^all_wins]])
    |> Data.Repo.update_all([])
  end

  @doc """
  Returns a boolean value if such room exists.
  """
  def exists_room?(roomname) do
    [] != "rooms"
          |> where([u], u.roomname == ^roomname)
          |> select([:roomname])
          |> Data.Repo.all
  end

  @doc """
  Returns an array containing all existing rooms in the game.
  """
  def get_all_room_names do
    "rooms"
    |> select([:roomname])
    |> Data.Repo.all
    |> Enum.uniq
    |> Enum.map(fn(x) -> x.roomname end)
  end

end