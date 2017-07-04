defmodule Game do
  defstruct [word: [], fails: 0, visualization: [], wrong_letters: []]

  def new(new_word) do
    %Game{word: String.codepoints(new_word), visualization: List.duplicate("*", String.length(new_word))}
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

  def change_state(%Game{fails: 7}, false, _), do: %Game{word: "Game Over"}
  # to-do: if we repeat wrong letter => dont add it to fails
  # aslo  some action when we win
  def change_state(game, false, letter), do: %{game | fails: game.fails + 1, wrong_letters: [letter] ++ game.wrong_letters}
  def change_state(game, true, letter) do
    %{game | visualization: find_index(game.visualization, game.word, letter, 0)}
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