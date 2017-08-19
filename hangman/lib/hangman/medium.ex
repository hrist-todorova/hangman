defmodule Hangman.Medium do
	use GenServer

	def start_link do
		GenServer.start_link(__MODULE__, %Game{}, name: :medium)

	end
	
	def init(_) do
		name = IO.gets "Hello stranger!\nWhat's your name? "
		registered = IO.gets "Have you played this game before? Please answer with yes or no. "
		enter(registered, name)

		{:ok, %Game{}}
	end

	defp enter(bool, name) do
		case bool do
			"yes\n" ->
				login(name)
			"no\n" ->
				register(name)
			_ ->
				recursive_login(name)
		end
	end

	defp login(name) do
		pass = IO.gets "What is your password? "
		case Hangman.Users.login(String.trim(name), String.trim(pass)) do
			:ok ->
				IO.puts "Great!\n"
			:error ->
				IO.puts "The password is wrong. "
				login(name)
		end
	end

	defp register(name) do
		pass = IO.gets "What password do you want to have? "
		case Hangman.Users.register(String.trim(name), String.trim(pass)) do
			:ok ->
				IO.puts "Great!\n"
			:error ->
				name = IO.gets "There is a person with the same name. Please choose another one: "
				register(name)
		end
	end

	defp recursive_login(name) do
		IO.puts "Please tell me again: "
		bool = IO.gets "Have you played this game before? Please answer with yes or no."
		enter(bool, name)
	end
	
end