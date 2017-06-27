defmodule Hangman.Game do
  use GenServer

  # API

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :our_game)
  end

  def register(user) when is_bitstring(user) do
    GenServer.cast(:our_game, {:register, user})
  end

  def get_messages do # DELETE THIS
    GenServer.call(:our_game, :get_messages)
  end



  # SERVER

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:register, user}, state) do
    {:noreply, Map.put(state, user, 0)}
  end

  def handle_call(:get_messages, _from, messages) do # DELETE THIS
    {:reply, messages, messages}
  end

end