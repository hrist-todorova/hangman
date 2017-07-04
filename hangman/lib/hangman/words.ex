defmodule Hangman.Words do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :words)
  end

  def add_word(word) when is_bitstring(word) do
    GenServer.cast(:words, {:add, word})
  end

  # DELETE THIS
  def get_messages do
    GenServer.call(:words, :get_messages)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_cast({:add, word}, state) do
    {:noreply, Enum.uniq([word | state])}
  end

  # DELETE THIS
  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end

end
