defmodule Room.Player do
  defstruct [nickname: "", pass: "", wins: 0]

  def new(player), do: %Room.Player{nickname: Player.name(player), pass: Player.password(player)}
    
end