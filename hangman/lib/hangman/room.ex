defmodule Hangman.Room do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :games)
  end


  # DELETE THIS
  def get_messages do
    GenServer.call(:our_game, :get_messages)
  end

  def init(_) do
    {:ok, %{}}
  end

  # DELETE THIS
  def handle_call(:get_messages, _from, messages) do 
    {:reply, messages, messages}
  end

end