defmodule Room do
  defstruct [name: "", players: [], counter: 0]

  def new(name), do: %Room{name: name}
 
  def insert_player(room, player) do
    %{room | players: [Room.Player.new(player) | room.players], counter: room.counter + 1}
  end

  def leaderboard(_room) do
    #to-do
  end

  

  
end
