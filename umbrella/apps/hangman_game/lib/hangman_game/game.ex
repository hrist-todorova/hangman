defmodule Game do
  @moduledoc """
  This module represents game functionality
  """

  defstruct [word: [], fails: 0, visualization: [], wrong_letters: [], player: "", room: ""]

  @doc """
  This function creates a new game.
  """
  def new(%{username: username, roomname: roomname}) do
    %{word: word} = Data.Word.Queries.get_a_word(username, roomname) 

    %Game{player: "#{username}", room: "#{roomname}", word: String.codepoints(word), 
          visualization: List.duplicate("*", String.length(word))}
  end

  @doc """
  This function returns a string in which every character that is not guessed yet is replaced by *.
  """
  def visualize(game) do
    List.to_string(game.visualization)
  end

  @doc """
  This function returns an array of all characters that we guessed but aren't in the word.
  """
  def wrong_letters(game) do
    game.wrong_letters
  end

  @doc """
  This function returns :win - if we won the game, :fail - if we lost the game or an instance of Game - if the game is still in progress.
  """
  def guess_letter(game, letter) when is_bitstring(letter) do
    change_state(game, Enum.member?(game.word, letter), letter)
  end

  @doc """
  Returns :win if the game is over, otherwise it returns the same game with updated visualization.
  """
  defp change_state(game, true, letter) do
    visual = find_index(game.visualization, game.word, letter, 0)
    if visual == game.word do
      :win
    else
      %{game | visualization: visual}
    end
  end

  @doc """
  This function returns :fail because we made 7 mistakes and lost the game.
  """
  defp change_state(%Game{fails: 7}, false, _) do
    :fail
  end

  @doc """
  This function returns the current game if we made the same mistake or updated game with the letter marked as wrong.
  """
  defp change_state(game, false, letter) do
    if Enum.member?(game.wrong_letters, letter) do
      game
    else
      %{game | fails: game.fails + 1, wrong_letters: [letter] ++ game.wrong_letters}
    end
  end

  @doc """
  This function find a letter in a word.
  """
  defp find_index(_, [], _, _), do: []
  defp find_index(visual, list, letter, index) do
    [vhead | vtail] = visual
    [head | tail] = list
    if head == letter do
      [letter] ++ find_index(vtail, tail, letter, index + 1)
    else
      [vhead] ++ find_index(vtail, tail, letter, index + 1)
    end
  end

end
