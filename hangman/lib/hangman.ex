defmodule Hangman do
	use Application
	
	@moduledoc """
	Starts the application
	"""

	def start(_type, _args) do
		import Supervisor.Spec, warn: false

		children = [
			supervisor(Database.Repo, []),
			worker(Hangman.Users, [])
		]

		opts = [strategy: :one_for_one, name: Hangman.Supervisor]
		Supervisor.start_link(children, opts)
		
	end

end
