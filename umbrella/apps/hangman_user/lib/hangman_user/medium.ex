defmodule HangmanUser.Medium do
  
  def user do
    username = IO.gets "Hello stranger!\nWhat's your name? "
    registered = IO.gets "Have you played this game before? Please answer with yes or no. "
    user = enter(registered, username)
    IO.puts "I see that you are ready to play! "
    bool = IO.gets "Do you want to create a new room? If you don't I'll show you the existing ones. Please answer with yes or no."
    room = rooms(bool)
    Data.Room.Queries.add_user_to_room(String.trim(room), String.trim(username))
    IO.puts "Please write Gameplay.start"
    %{username: String.trim(username), roomname: String.trim(room)}
  end

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

  defp login(username) do
    password = IO.gets "What is your password? "
    case HangmanUser.Interface.login(String.trim(username), String.trim(password)) do
      :ok ->
        IO.puts "Great!\n"
        %{username: String.trim(username)}
      :error ->
        IO.puts "The password is wrong. "
        IO.puts "Let's try again .."
        HangmanUser.Medium.user
    end
  end

  defp register(username) do
    password = IO.gets "What password do you want to have? "
    case HangmanUser.Interface.register(String.trim(username), String.trim(password)) do
      :ok ->
        IO.puts "Great!\n"
        %{username: String.trim(username)}
      :error ->
        IO.puts "There is a person with the same name. "
        IO.puts "Let's try again .."
        HangmanUser.Medium.user
    end
  end

  defp recursive_login(name) do
    IO.puts "Please tell me again: "
    bool = IO.gets "Have you played this game before? Please answer with yes or no."
    enter(bool, name)
  end

end