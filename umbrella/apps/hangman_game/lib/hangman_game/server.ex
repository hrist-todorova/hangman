defmodule HangmanGame.Server do
  use GenServer

  @moduledoc """
  This module is a Server in which we hold information about the players and register or log them in the game
  """

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :users)
  end

  @doc """
  This function returns registers a new player in the game. When this is succesful it returns :ok. When there is somebody with the same username it returns :error.
  """
  def register(username, password) do
    GenServer.call(:users, {:register, username, password})
  end

  @doc """
  This function logs the user in the database. It returns :error if we choose a wrong password or non-existing username. Otherwise it returns :ok.
  """
  def login(username, password) do
    GenServer.call(:users, {:login, username, password})
  end

  def init(_) do
    {:ok, Data.User.Queries.all_users}
  end

  def handle_call({:register, username, password}, _from, state) do
    index = Enum.find_index(state, fn(x) -> x.username == username end)
    if index == nil do
      Data.User.Queries.add_player(username, password)
      {:reply, :ok, [ %{username: "#{username}", password: "#{password}", wins: 0, total: 0} | state ]}
    else
      {:reply, :error, state}
    end
  end

  def handle_call({:login, username, password}, _from, state) do
    index = Enum.find_index(state, fn(x) -> x.username == username and x.password == password end)
    if index != nil do
      {:reply, :ok, state}
    else
      {:reply, :error, state}
    end
  end

end
