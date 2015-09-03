defmodule Ikki.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string, size: 40, null: false

      timestamps
    end

    create index(:rooms, [:name], unique: true)
  end
end
