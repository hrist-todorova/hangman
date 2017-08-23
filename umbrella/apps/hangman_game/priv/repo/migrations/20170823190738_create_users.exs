defmodule Data.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :username, :string
      add :password, :string
      add :wins, :integer
      add :total, :integer
    end
  end
end
