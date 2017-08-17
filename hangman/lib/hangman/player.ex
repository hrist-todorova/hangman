defmodule Player do
  defstruct [nickname: "", pass: "", wins: 0, total_games: 0]

  def login(string) do
    data = String.split(string)
    %Player{nickname: Enum.at(data, 0), pass: Enum.at(data, 1), wins: Enum.at(data, 2), total_games: Enum.at(data,3)}

    #to-do convert wins and total games to integers!!!
  end

  def new(name, password), do: %Player{nickname: name, pass: password}

  def name(player) do
    player.nickname
  end

  def password(player) do
    player.pass
  end

















  

  def copy(other) do
    %Player{nickname: other.nickname, pass: other.pass, wins: other.wins, 
      total_games: other.total_games}
  end

  

  def add_word(word, player) do
    Hangman.Words.add_word(word)
  end

  def guess_word(player) do
    word = get_word(player)
   # Game.new(word)
  end

  defp get_word(player) do
    Hangman.Words.get_a_word
  end
    
end