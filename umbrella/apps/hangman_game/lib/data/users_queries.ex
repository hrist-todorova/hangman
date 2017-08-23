defmodule Data.User.Queries do
  import Ecto.Query

  def all_users do
    "users" 
		|> select([:username, :password, :wins, :total]) 
    |> Data.Repo.all
	end
	
  def add_player(name, pass) do
    Data.Repo.insert(%Data.User{username: "#{name}", password: "#{pass}", wins: 0, total: 0})
  end

end