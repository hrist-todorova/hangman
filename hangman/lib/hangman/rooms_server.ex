defmodule Hangman.Rooms do
  use GenServer

  @moduledoc """
  This is the server containing game rooms
  """

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: :rooms)
  end

  @doc """
  Returns an object `Room` with the given name. If it already exist we get the message: "A room with this name already exists"
  """

  def add_new_room(name) do
    GenServer.call(:rooms, {:add, name})
  end

  def insert_a_player(player, name) do
    GenServer.call(:rooms, {:insert, player, name})
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:add, name}, _from, state) do
    if !Map.has_key?(state, name) do
      {:reply, Room.new(name), Map.put(state, name, Room.new(name))}
    else
      {:reply, "A room with this name already exists", state}
    end
  end

  def handle_call({:insert, player, name}, _from, state) do
    if Map.has_key?(state, name) do
      {:ok, room} = Map.fetch(state, name)
      room = Room.insert_player(room, player)
      {:reply, room , Map.put(state, name, room)}
    else
      {:reply, "There is not such room", state}
    end
  end
  
end