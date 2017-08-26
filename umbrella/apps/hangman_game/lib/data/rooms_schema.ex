defmodule Data.Room do
  use Ecto.Schema

  @moduledoc false
    
  schema "rooms" do
    field :roomname, :string
    field :username, :string
    field :wins, :integer
  end
    
end