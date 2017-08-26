defmodule HangmanGameTest do
  use ExUnit.Case
  doctest HangmanGame

  test "accepts a correct letter and returns current game" do
    word = "parrot"

    game = %Game{
      player: "", 
      room: "", 
      word: String.codepoints(word),
      visualization: List.duplicate("*", String.length(word)),
      fails: 0,
      wrong_letters: []
    }

    result =  Game.guess_letter(game, "p")
    assert Game.visualize(result) == "p*****"
  end
end
