defmodule Data.User.Queries do
  import Ecto.Query

  @moduledoc """
  This module provides queries which access and change information about the users in the game.
  """

  @doc """
  Returns a list of maps which describe each user: its username, password, wins and total number of played games.
  """
  def all_users do
    "users" 
    |> select([:username, :password, :wins, :total]) 
    |> Data.Repo.all
  end
  
  @doc """
  This function register a new player in the game.
  """
  def add_player(username, password) do
    Data.Repo.insert(%Data.User{username: "#{username}", password: "#{password}", wins: 0, total: 0})
  end

  @doc """
  This function adds a win into the users account.
  """
  def add_win(username) do
    [%{wins: all_wins, total: all_games}] = "users"
                         |> where([u], u.username == ^username)
                         |> select([:wins, :total]) 
                         |> Data.Repo.all
    all_wins = all_wins + 1
    all_games = all_games + 1

    from(u in Data.User, where: u.username == ^username, update: [set: [wins: ^all_wins, total: ^all_games]])
    |> Data.Repo.update_all([])
  end

  @doc """
  This function adds a lost into the users account.
  """
  def add_fail(username) do
    [%{total: all_games}] = "users"
                            |> where([u], u.username == ^username)
                            |> select([:total]) 
                            |> Data.Repo.all
    all_games = all_games + 1
   
    from(u in Data.User, where: u.username == ^username, update: [set: [total: ^all_games]])
    |> Data.Repo.update_all([])
  end

end