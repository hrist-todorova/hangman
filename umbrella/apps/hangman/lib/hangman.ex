defmodule Hangman do
	use Application
	
	@moduledoc """
	Starts the application
	"""

	def start(_type, _args) do
		import Supervisor.Spec, warn: false

		children = [
			supervisor(Database.Repo, []),
			worker(Hangman.Users, []),
			worker(Hangman.Medium, [])
		]

		opts = [strategy: :one_for_one, name: Hangman.Supervisor]
		Supervisor.start_link(children, opts)

	end

	#TO-DO's
	# tests
	# full documentation
	# user as otp applications?
	# users on different nodes
	# number of people in each room
	# leaderboard on demand top 10 + our score
	# what happens if we kill this and that
	#save current game

end
