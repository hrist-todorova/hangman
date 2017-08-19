defmodule Player do
  defstruct [username: "", password: "", wins: 0, total: 0]

  def login(%{password: pass, total: nil, username: name, wins: nil}) do
    %Player{username: name, password: pass}
  end
  def login(%{password: pass, total: total_games, username: name, wins: wins_count}) do
    %Player{username: name, password: pass, wins: wins_count, total: total_games}
  end

  def new(name, password), do: %Player{username: name, password: password}

  def name(player) do
    player.username
  end

  def password(player) do
    player.password
  end

















  

  def copy(other) do
    %Player{username: other.username, password: other.password, wins: other.wins, 
      total: other.total}
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