defmodule Room.Player do
  defstruct [nickname: "", wins: 0]

  def new(name), do: %Room.Player{nickname: name}
    
end