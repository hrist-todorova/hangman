defmodule Player do
  defstruct [nickname: "", wins: 0, total_games: 0, password: ""]

  def new(), do: %Player{}
    
end