defmodule Database.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :username, :string
      add :wins, :integer
    end
  end
end
