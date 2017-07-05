defmodule Hangman.Users do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :users)
  end

  def register(user, password) when is_bitstring(user) do
    # if already exists show some stuff
    GenServer.cast(:users, {:register, user, password})
  end

  #to-do: add login

  # DELETE THIS
  def state do
    GenServer.call(:users, :state)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_cast({:register, user, password}, state) do
    {:noreply, Enum.uniq([Player.new(user, password)] ++ state)}
  end

  # DELETE THIS
  def handle_call(:state, _from, state) do 
    {:reply, state, state}
  end

end