defmodule Users.User do
  use Ecto.Schema

  schema "people" do
    field :username, :string
    field :password, :string
    field :wins, :integer
    field :total, :integer
  end
end