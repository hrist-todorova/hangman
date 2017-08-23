defmodule Data.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :word, :string
      add :username, :string
      add :roomname, :string
    end
  end
end
