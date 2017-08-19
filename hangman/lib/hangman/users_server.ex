defmodule Hangman.Users do
  use GenServer

  @moduledoc """
  This is the server containing the users
  """

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :users)
  end

  @doc """
  Returns an object Player with the same password and username. If it's in the database already we get the message:
  "You can't register with these username and password"
  """

  def register(user, password) do
    GenServer.call(:users, {:register, user, password})
  end

  @doc """
  Returns an object Player with the same password and username. If it's not in the database we get the message:
  "The username or password is wrong"
  """
  def login(user, password) do
    GenServer.call(:users, {:login, user, password})
  end

  def init(_) do
    {:ok, Hangman.Users.Queries.all_users}
  end

  def handle_call({:register, user, password}, _from, state) do
    index = Enum.find_index(state, fn(x) -> Player.name(x) == user end)
    if index == nil do
      Hangman.Users.Queries.add_player(user, password)
      {:reply, :ok, [ Player.new(user, password) | state ]}
    else
      {:reply, :error, state}
    end
  end

  def handle_call({:login, user, password}, _from, state) do
    index = Enum.find_index(state, fn(x) -> Player.name(x) == user and Player.password(x) == password end)
    if index != nil do
      {:reply, :ok, state}
    else
      {:reply, :error, state}
    end
  end

end