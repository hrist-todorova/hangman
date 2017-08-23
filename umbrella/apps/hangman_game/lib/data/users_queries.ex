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

end