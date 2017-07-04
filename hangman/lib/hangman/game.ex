defmodule Game do
  defstruct [word: [], fails: 0, visualization: []]

  def new(new_word) do
    word = String.codepoints(new_word)
    %Game{word: word, visualization: [List.first(word)] ++ List.duplicate("*", String.length(new_word) - 2) ++ [List.last(word)]}
  end

  def visualize(game) do
    List.to_string(game.visualization)
  end

  def guess_letter(game, letter) when is_bitstring(letter) do
    change_state(game, Enum.member?(game.word, letter), letter)
  end

  def change_state(game, false, _), do: %{game | fails: game.fails + 1}
  def change_state(game, true, letter) do
    %{game | visualization: find_index(game.visualization, game.word, letter, 0)}
  end





  defp find_index(visual, [], letter, _), do: []
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