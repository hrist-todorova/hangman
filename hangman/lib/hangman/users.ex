defmodule Hangman.Users do
  use GenServer

  @moduledoc """
    This is the API of the application
  """

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :api)
  end

  def register(user, password) when is_bitstring(user) and is_bitstring(password) do
    # if already exists show some stuff
    GenServer.cast(:api, {:register, user, password})
  end

  @doc """
    Returns an object Player with the same password and username. If it's not in the database we get the message:
    "The username or password is wrong"
  """
  def login(user, password) when is_bitstring(user) and is_bitstring(password) do
    GenServer.call(:api, {:login, user, password})
  end
  










  def get_user(name) do
    #GenServer.call(:api, {:get, name})
  end


  def state do
    #GenServer.call(:api, :state)
  end

  def init(_) do
    {:ok, Hangman.Users.Parser.parse_data}
  end

  def handle_cast({:register, user, password}, state) do
    #{:noreply, Map.put_new(state, user, Player.new(user, password))}
  end

  def handle_call({:login, user, password}, _from, state) do
    index = Enum.find_index(state, fn(x) -> Player.name(x) == user and Player.password(x) == password end)
    if index != nil do
      {:ok, user} = Enum.fetch(state, index)
      {:reply, user, state}
    else
      {:reply, "The username or password is wrong", state}
    end
  end
  
  def handle_call(:state, _from, state) do 
    #{:reply, state, state}
  end
  def handle_call({:get, name}, _from, state) do
    #{:ok, user} = Map.fetch(state, name)
    #{:reply, user, state}
  end

end