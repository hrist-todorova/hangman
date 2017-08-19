defmodule Database.Word do
  use Ecto.Schema
    
  schema "words" do
    field :word, :string
    field :user, :string
  end
		
end