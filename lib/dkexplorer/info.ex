defmodule Dkexplorer.Info do
  use Ecto.Schema
  import Ecto.Changeset


  schema "info" do
    field :aitemplates, :integer
    field :hashrate, :float

    timestamps()
  end

  @doc false
  def changeset(info, attrs) do
    info
    |> cast(attrs, [:hashrate, :aitemplates])
    |> validate_required([:hashrate, :aitemplates])
  end
end

defmodule Dkexplorer.Info.Query do
    alias Dkexplorer.Info
    import Ecto.Query, only: [from: 2]

    def get_last_num do
        from(
            i in Info,
            order_by: [desc: i.inserted_at],
            limit: 1,
            select: i.aitemplates
        ) |> Dkexplorer.Repo.one
    end

    def get_last_entry do
        from(
            i in Info,
            order_by: [desc: i.inserted_at],
            limit: 1,
            select: i
        ) |> Dkexplorer.Repo.one
    end

    def insert_info do
      %Info{
        aitemplates: __MODULE__.get_last_num,
        hashrate: ((:rand.uniform * 0.3) + 10) |> Float.round(2)
      } |> Dkexplorer.Repo.insert
    end

    def insert_new_block do
      %Info{
        aitemplates: __MODULE__.get_last_num + 1,
        hashrate: ((:rand.uniform * 0.3) + 10) |> Float.round(2)
      } |> Dkexplorer.Repo.insert
    end
end
