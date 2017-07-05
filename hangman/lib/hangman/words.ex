defmodule Hangman.Words do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :words)
  end

  def add_word(word, user) when is_bitstring(word) do
    GenServer.cast(:words, {:add, word, user})
  end

  def get_all_words(player) do
    GenServer.call(:words, {:get_words, player})
  end

  def init(_) do
    {:ok, %{}} # FORMAT: word => user
  end

  def handle_cast({:add, word, user}, state) do
    {:noreply, Map.put_new(state, word, user)}
  end

  def handle_call({:get_words, player}, _from, messages) do
    # да добавя да не може да изберем дума, която ние сме вкарали
    {:reply, messages, messages}
  end

end
