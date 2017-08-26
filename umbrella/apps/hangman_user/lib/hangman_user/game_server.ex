defmodule HangmanUser.Game.Server do
  use GenServer

  @moduledoc """
  This is the server module in which we save current game.
  """

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: :guest)
  end

  @doc """
  This function starts a game by calling a Game.new/1.
  """
  def start_game do
    GenServer.call(:guest, {:start})
  end

  @doc """
  This function returns the game state.
  """
  def get_game_stats do
    GenServer.call(:guest, {:game})
  end

  @doc """
  This accepts a letter and returns :stop_win if we won the game, :stop_fail if we lost the game and :ok if the game is not done yet.
  """
  def guess_a_letter(letter) do
    GenServer.call(:guest, {:letter, letter})
  end

  @doc """
  This functions adds a word to be guessed in the current room.
  """
  def add_word(word) do
    GenServer.call(:guest, {:add, word})
  end

  @doc """
  This functions returns the leaderboard.
  """
  def get_leaders do
    GenServer.call(:guest, :leaders)
  end

  def init(_) do
    {:ok, HangmanUser.Medium.user}
  end

  def handle_call({:start}, _from, state) do
    {:reply, :ok, Game.new(state)}
  end

  def handle_call({:game}, _from, state) do
    {:reply, state, state}
  end
  
  def handle_call({:letter, letter}, _from, state) do
    game = Game.guess_letter(state, letter)
    case game do
      :win ->
        Data.User.Queries.add_win(state.player)
        Data.Room.Queries.add_win(state.player, state.room)
        {:reply, :stop_win, %{username: state.player, roomname: state.room}}
      :fail ->
        Data.User.Queries.add_fail(state.player)
        {:reply, :stop_fail, %{username: state.player, roomname: state.room}}
      _ ->
        {:reply, :ok, game}
    end
  end

  def handle_call({:add, word}, _from, state) do
    Data.Word.Queries.add_word(word, state.username, state.roomname)
    {:reply, :ok, state}
  end

  def handle_call(:leaders, _from, state) do
    {:reply, Data.Room.Queries.leaderboard(state.roomname), state}
  end

  
end