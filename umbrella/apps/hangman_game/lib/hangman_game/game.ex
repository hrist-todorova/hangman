defmodule Game do
  @moduledoc """
  This module represent game functionality
  """

  defstruct [word: [], fails: 0, visualization: [], wrong_letters: [], player: "", room: ""]

  def new(%{username: username, roomname: roomname}) do
    %{word: word} = Data.Word.Queries.get_a_word(username, roomname) 
    %Game{player: "#{username}", room: "#{roomname}", word: String.codepoints(word), 
          visualization: List.duplicate("*", String.length(word))}
  end

  def visualize(game) do
    List.to_string(game.visualization)
  end

  def wrong_letters(game) do
    game.wrong_letters
  end

  def guess_letter(game, letter) when is_bitstring(letter) do
    change_state(game, Enum.member?(game.word, letter), letter)
  end

  def change_state(game, true, letter) do
    visual = find_index(game.visualization, game.word, letter, 0)
    if visual == game.word do
      :win
    else
      %{game | visualization: visual}
    end
  end

  def change_state(%Game{fails: 7}, false, _) do
    :fail
  end

  def change_state(game, false, letter) do
    if Enum.member?(game.wrong_letters, letter) do
      game
    else
      %{game | fails: game.fails + 1, wrong_letters: [letter] ++ game.wrong_letters}
    end
  end

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