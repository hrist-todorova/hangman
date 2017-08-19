defmodule Game do
	@moduledoc """
	This module defines a game in a gameroom
	"""

	defstruct [word: [], fails: 0, visualization: [], wrong_letters: [], player: Room.Player.new, room: ""]

	@doc """
	Create a new game by giving the word, which has to be guessed, the player object and the name of the room we are playing in
	"""

	def new(new_word, player, room_name) do
		%Game{word: String.codepoints(new_word), visualization: List.duplicate("*", String.length(new_word)),
					room: room_name, player: Room.Player.new(player)}
	end

	@doc """
	Returns a string which presents the word we are guessing: the letters which has to be guessed are replaced by '*' symbol
	"""

	def visualize(game) do
		List.to_string(game.visualization)
	end

	@doc """
	Returns an array containing the lettes which are not in the word but we have guessed that they are 
	"""

	def wrong_letters(game) do
		game.wrong_letters
	end

	@doc """
	Returns the game with changed state. If the game if over the function returns the player
	"""

	def guess_letter(game, letter) when is_bitstring(letter) do
		change_state(game, Enum.member?(game.word, letter), letter)
	end

	def change_state(game, true, letter) do
		visual = find_index(game.visualization, game.word, letter, 0)
		if visual == game.word do
			%{game.player | wins: game.player.wins + 1}
		else
			%{game | visualization: visual}
		end
	end

	def change_state(%Game{fails: 7, player: p}, false, _) do
		%{p | lost_games: p.lost_games + 1}
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