defmodule Hangman.Room do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :game)
  end

  def add_player(name) do
    GenServer.cast(:game, {:add, name})
  end

  # DELETE THIS
  def state do
    GenServer.call(:game, :state)
  end

  def init(_) do
    {:ok, %{}}
  end

  # DELETE THIS
  def handle_call(:state, _from, state) do 
    {:reply, state, state}
  end

  def handle_cast({:add, name}, state) do
    {:noreply, Map.put(state, name, [wins: 0, fails: 0])}
  end

end