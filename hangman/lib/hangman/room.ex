defmodule Room do
  defstruct [name: "", players: []]

  def new(name), do: %Room{name: name}

  def insert_player(room, player) do
    %{room | players: [player | room.players]}
  end
  
end