defmodule Data.Word do
  use Ecto.Schema
  
  @moduledoc false

  schema "words" do
    field :word, :string
    field :username, :string
    field :roomname, :string
  end
end