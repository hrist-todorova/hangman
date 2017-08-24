defmodule HangmanUser.Medium do
  
  def user do
    username = IO.gets "Hello stranger!\nWhat's your name? "
    registered = IO.gets "Have you played this game before? Please answer with yes or no. "
    user = enter(registered, username)
    user
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