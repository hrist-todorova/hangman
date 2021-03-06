defmodule HangmanUser.Medium do

  @moduledoc """
  This module serves as greeter and finds out the players username and password
  """
  
  @doc """
  Interaction with the user. Returns a map with keys: the chosen username and the room in which that person will play.
  """
  def user do
    username = IO.gets "Hello stranger!\nWhat's your name? "
    registered = IO.gets "Have you played this game before? Please answer with yes or no. "
    username = enter(registered, username)
    IO.puts "I see that you are ready to play! "
    bool = IO.gets "Do you want to create a new room? If you don't I'll show you the existing ones. Please answer with yes or no."
    room = rooms(bool)
    Data.Room.Queries.add_user_to_room(String.trim(room), String.trim(username))
    IO.puts "Please write Gameplay.start"
    %{username: String.trim(username), roomname: String.trim(room)}
  end

  @doc """
  Returns the chosen room's name.
  """
  defp rooms(bool) do
    case bool do
      "yes\n" ->
        name = IO.gets "OK. Choose a name: "
        if Data.Room.Queries.exists_room?(String.trim(name)) do
          IO.puts "There is a room named like this."
          rooms("yes\n")
        end
        name
      "no\n" ->
        IO.puts "ALL ROOMS: "
        IO.inspect Data.Room.Queries.get_all_room_names
        name = IO.gets "In which room you wish to join?"
        if !Data.Room.Queries.exists_room?(String.trim(name)) do
          IO.puts "There isn't a room named like this."
          rooms("no\n")
        end
        name
      _ ->
        new_bool = IO.gets "I didn't understand. Tell me again: "
        rooms(new_bool)
    end
  end

  @doc """
  Returns the username our player will have.
  """
  defp enter(bool, username) do
    case bool do
      "yes\n" ->
        login(username)
      "no\n" ->
        register(username)
      _ ->
        recursive_login(username)
    end
  end

  @doc """
  If we enter the correct password for the user username we continue with the game. If not, we are asked again to give our name and password.
  """
  defp login(username) do
    password = IO.gets "What is your password? "
    case HangmanGame.Server.login(String.trim(username), String.trim(password)) do
      :ok ->
        IO.puts "Great!\n"
        String.trim(username)
      :error ->
        IO.puts "The password is wrong. Let's try again .."
        name = IO.gets "What is your name?"
        login(name)
    end
  end

  @doc """
  Returns our username if there isn't someone with the same in the database. Otherwise we have to think of another one.
  """
  defp register(username) do
    password = IO.gets "What password do you want to have? "
    case HangmanGame.Server.register(String.trim(username), String.trim(password)) do
      :ok ->
        IO.puts "Great!\n"
        String.trim(username)
      :error ->
        IO.puts "There is a person with the same name. Let's try again .."
        name = IO.gets "What is your name?"
        register(name)
    end
  end

  @doc """
  Returns us to the enter function because we made a mistake.
  """
  defp recursive_login(name) do
    IO.puts "Please tell me again: "
    bool = IO.gets "Have you played this game before? Please answer with yes or no."
    enter(bool, name)
  end

end