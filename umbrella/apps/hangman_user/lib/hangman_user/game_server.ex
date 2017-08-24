defmodule HangmanUser.Game.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(_) do
    {:ok, HangmanUser.Medium.user}
  end

end