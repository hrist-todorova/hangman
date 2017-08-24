defmodule Data.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :roomname, :string
      add :username, :string
      add :wins, :integer
    end
  end
end
