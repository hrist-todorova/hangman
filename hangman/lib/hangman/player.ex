defmodule Player do
  defstruct [nickname: "", wins: 0, total_games: 0, pass: "", guessed_words: []]

  def new(name, password), do: %Player{nickname: name, pass: password}

  def add_word(word, player) do
    Hangman.Words.add_word(word, player)
  end

  def get_word(player) do
    List.first(Hangman.Words.get_all_words(player) -- player.guessed_words)
  end
    
end