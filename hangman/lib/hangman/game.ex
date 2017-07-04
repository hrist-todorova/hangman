defmodule Hangman.Game do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :our_game)
  end

  # to-do: register with password?
  def register(user) when is_bitstring(user) do
    GenServer.cast(:our_game, {:register, user})
  end

  # DELETE THIS
  def get_messages do
    GenServer.call(:our_game, :get_messages)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:register, user}, state) do
    {:noreply, Map.put(state, user, 0)} # 0 means zero wins in the game
  end

  # DELETE THIS
  def handle_call(:get_messages, _from, messages) do 
    {:reply, messages, messages}
  end

end