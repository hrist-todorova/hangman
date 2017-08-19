defmodule Hangman.Users.Queries do
  import Ecto.Query

  def all_users do
    "users" 
    |> select([:username, :password, :wins, :total]) 
    |> Database.Repo.all
    |> Enum.map(fn(x) -> Player.login(x) end)
  end

  def add_player(name, pass) do
    Database.Repo.insert(%Database.User{username: "#{name}", password: "#{pass}"})
  end

end





          