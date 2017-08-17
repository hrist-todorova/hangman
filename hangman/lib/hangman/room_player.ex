defmodule Room.Player do
  defstruct [nickname: "", pass: "", wins: 0, lost_games: 0]

  def new(%Room.Player{nickname: n, pass: p, wins: w, lost_games: l}) do
    %Room.Player{nickname: n, pass: p, wins: w, lost_games: l}
  end
  def new(player), do: %Room.Player{nickname: Player.name(player), pass: Player.password(player)}
  def new, do: %Room.Player{}
    
end