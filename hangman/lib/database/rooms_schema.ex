defmodule Database.Room do
  use Ecto.Schema
    
  schema "rooms" do
    field :name, :string
    field :username, :string
    field :wins, :integer
  end
    
  end