defmodule Hangman.Users.Queries do
  import Ecto.Query

  @moduledoc """
  This module provides functions which execute queries on our users database
  """

  @doc """
  Returns an array of all users in the database
  """

  def all_users do
    "users" 
		|> select([:username, :password, :wins, :total]) 
    |> Database.Repo.all
    |> Enum.map(fn(x) -> Player.login(x) end)
	end
	
	@doc """
  Adds user into the database
  """

  def add_player(name, pass) do
    Database.Repo.insert(%Database.User{username: "#{name}", password: "#{pass}"})
  end

end





          