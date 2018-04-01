defmodule Dkexplorer.Repo.Migrations.CreateInfo do
  use Ecto.Migration

  def change do
    create table(:info) do
      add :hashrate, :float
      add :aitemplates, :integer

      timestamps()
    end

  end
end
