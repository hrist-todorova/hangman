defmodule Data.User.Queries do
  import Ecto.Query

  def all_users do
    "users" 
    |> select([:username, :password, :wins, :total]) 
    |> Data.Repo.all
  end
  
  def add_player(username, password) do
    Data.Repo.insert(%Data.User{username: "#{username}", password: "#{password}", wins: 0, total: 0})
  end

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