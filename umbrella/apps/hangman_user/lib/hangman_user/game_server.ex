defmodule HangmanUser.Game.Server do
  use GenServer

  @moduledoc """
  This is the server module in which we save current game.
  """

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: :guest)
  end

  def start_game do
    GenServer.call(:guest, {:start})
  end

  def get_game_stats do
    GenServer.call(:guest, {:game})
  end

  def guess_a_letter(letter) do
    GenServer.call(:guest, {:letter, letter})
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
        {:reply, :stop_win, %{username: state.player, roomname: state.room}}
      :fail ->
        Data.User.Queries.add_fail(state.player)
        {:reply, :stop_fail, %{username: state.player, roomname: state.room}}
      _ ->
        {:reply, :ok, game}
    end
  end
  
end