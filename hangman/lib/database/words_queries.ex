defmodule Hangman.Words.Queries do
	import Ecto.Query

  def add_word(new_word, user) do
    Database.Repo.insert(%Database.Word{word: "#{new_word}", user: "#{user}"})
	end
	
	def get_a_word(not_from_user) do
		"words" 
		|> where([u], u.user != ^not_from_user)
		|> select([:word]) 
		|> Database.Repo.all
		|> Enum.random
	end

	def get_a_word_from_a_friend(friend_name) do
		"words" 
		|> where([u], u.user == ^friend_name)
		|> select([:word]) 
		|> Database.Repo.all
		|> Enum.random
	end

end
