defmodule Gameplay do

  @moduledoc """
  This is a module which interacts with the user while playing a game
  """
  
  def start do
    IO.puts "Game started"
    HangmanUser.Game.Server.start_game

    IO.puts "Word: "
    IO.puts Game.visualize(HangmanUser.Game.Server.get_game_stats)
    IO.puts "Wrong letters: "
    IO.inspect Game.wrong_letters(HangmanUser.Game.Server.get_game_stats)
    
    ask_for_letter
    
  end

  def ask_for_letter do
    letter = IO.gets "Tell me a letter: "
    result = HangmanUser.Game.Server.guess_a_letter(String.trim(letter))
    case result do
      :stop_win ->
        IO.puts "You won the game"
      :stop_fail ->
        IO.puts "You lost this game"
      _ ->
        IO.puts "\n"
        IO.puts "Word: "
        IO.puts Game.visualize(HangmanUser.Game.Server.get_game_stats)
        IO.puts "Wrong letters: "
        IO.inspect Game.wrong_letters(HangmanUser.Game.Server.get_game_stats)   
        ask_for_letter
    end
    bool = IO.gets "Do you want to play again? "
    if(bool == "yes\n") do
      start
    else
      exit("Goodbye, my friend!")
    end
  end

  def add_word do
    get = IO.gets "Do you want to add a word? "
    case get do
      "yes\n" ->
        word = IO.gets "What's the word? "
        HangmanUser.Game.Server.add_word(word)
        add_word
      "no\n" -> 
        IO.puts "Ok."
    end
  end

end