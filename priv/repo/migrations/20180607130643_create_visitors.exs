defmodule Jumppa.Repo.Migrations.CreateVisitors do
  use Ecto.Migration

  def change do
    create table(:visitors) do
      add :first_name, :string
      add :last_name, :string
      add :address, :string
      add :zip, :string
      add :municipality, :string

      timestamps()
    end

  end
end
