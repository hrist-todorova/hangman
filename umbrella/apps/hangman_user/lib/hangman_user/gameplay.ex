defmodule Gameplay do
  
  def start do
    IO.puts "Game started"
    HangmanUser.Game.Server.start_game
    IO.inspect HangmanUser.Game.Server.get_game_stats
    IO.puts Game.visualize(HangmanUser.Game.Server.get_game_stats)
    IO.puts Game.wrong_letters(HangmanUser.Game.Server.get_game_stats)
    if exiter == false do
      ask_for_letter
    end
  end

  def ask_for_letter do
    letter = IO.gets "Tell me a letter"
    result = HangmanUser.Game.Server.guess_a_letter(String.trim(letter))
    case result do
      :stop_win ->
        IO.puts "You won the game"
      :stop_fail ->
        IO.puts "You lost this game"
      _ ->
        IO.puts Game.visualize(HangmanUser.Game.Server.get_game_stats)
        IO.puts Game.wrong_letters(HangmanUser.Game.Server.get_game_stats)
        ask_for_letter
    end
  end

end