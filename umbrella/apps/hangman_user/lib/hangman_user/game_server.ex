defmodule HangmanUser.Game.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def start_game do
    GenServer.call(server, {:start})
  end

  def init(_) do
    {:ok, HangmanUser.Medium.user}
  end

  def handle_call({:start}, _from, state) do
    
  end
  

end