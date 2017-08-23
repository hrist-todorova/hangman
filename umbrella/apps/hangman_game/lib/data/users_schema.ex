defmodule Data.User do
  use Ecto.Schema
  
  schema "users" do
    field :username, :string
    field :password, :string
    field :wins, :integer
    field :total, :integer
  end
end