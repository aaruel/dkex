defmodule Dkexplorer.Repo.Migrations.CreateBlock do
  use Ecto.Migration

  def change do
    create table(:block) do
      add :template, :string
      add :hash, :string
      add :tx, :integer
      add :miner, :string
      add :size, :integer

      timestamps()
    end

  end
end
