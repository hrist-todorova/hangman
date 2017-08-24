defmodule Data.Room do
  use Ecto.Schema
    
  schema "rooms" do
    field :roomname, :string
    field :username, :string
    field :wins, :integer
  end
    
end