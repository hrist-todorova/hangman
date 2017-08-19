defmodule Hangman.Rooms.Queries do
	import Ecto.Query

	def add_user_to_room(room_name, user) do
		Database.Repo.insert(%Database.Room{name: "#{room_name}", username: "#{user}", wins: 0})
	end
	
	def get_all_rooms_names do
		"rooms"
		|> select([:name])
		|> Database.Repo.all
		|> Enum.uniq
		|> Enum.map(fn(x) -> x.name end)
	end

end