defmodule Database.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password, :string
      add :wins, :integer
      add :total, :integer
    end
  end
end
