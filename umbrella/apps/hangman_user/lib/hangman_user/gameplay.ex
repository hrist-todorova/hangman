defmodule Gameplay do

  @moduledoc """
  This is a module which interacts with the user.
  """
  
  @doc """
  This function starts a game by asking for words to put in the database for other users to guess.
  After that it creates a game and interacts with the user.
  """
  def start do
    add_word
    IO.puts "Game started"
    
    HangmanUser.Game.Server.start_game
    IO.puts "Word: "
    IO.puts Game.visualize(HangmanUser.Game.Server.get_game_stats)
    IO.puts "Wrong letters: "
    IO.inspect Game.wrong_letters(HangmanUser.Game.Server.get_game_stats)
    
    ask_for_letter

    IO.puts HangmanUser.Game.Server.get_leaders
    bool = IO.gets "Do you want to play again? "
    if(bool == "yes\n") do
      start
    else
      exit("Goobye :)")
    end
  end

  @doc """
  This function calls itself until the game is done.
  """
  defp ask_for_letter do
    letter = IO.gets "Tell me a letter: "
    result = HangmanUser.Game.Server.guess_a_letter(String.trim(letter))
    case result do
      :stop_win ->
        IO.puts "You won the game"
        IO.puts "\n"
      :stop_fail ->
        IO.puts "You lost this game"
        IO.puts "\n"
      _ ->
        IO.puts "\n"
        IO.puts "Word: "
        IO.puts Game.visualize(HangmanUser.Game.Server.get_game_stats)
        IO.puts "Wrong letters: "
        IO.inspect Game.wrong_letters(HangmanUser.Game.Server.get_game_stats)   
        ask_for_letter
    end 
  end

  @doc """
  With this function we can add words in the database for this room.
  """
  defp add_word do
    bool = IO.gets "Do you want to add a word? "
    case bool do
      "yes\n" ->
        word = IO.gets "What's the word? "
        HangmanUser.Game.Server.add_word(String.trim(word))
        add_word
      _ -> 
        IO.puts "Ok."
    end
  end

end