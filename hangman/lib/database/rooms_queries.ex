defmodule Hangman.Rooms.Queries do
	import Ecto.Query

	def add_user_to_room(room_name, user) do
		Database.Repo.insert(%Database.Room{name: "#{room_name}", username: "#{user}", wins: 0})
	end
	
	def print_all_rooms do
		"rooms"
		|> select([:name])
		|> Database.Repo.all
		|> Enum.uniq
	end

end