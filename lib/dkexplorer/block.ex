defmodule Dkexplorer.Block do
  use Ecto.Schema
  import Ecto.Changeset


  schema "block" do
    field :hash, :string
    field :miner, :string
    field :size, :integer
    field :template, :string
    field :tx, :integer

    timestamps()
  end

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, [:template, :hash, :tx, :miner, :size])
    |> validate_required([:template, :hash, :tx, :miner, :size])
  end
end

defmodule Dkexplorer.Block.Query do
    alias Dkexplorer.Block
    import Ecto.Query, only: [from: 2]

    defp random_gril do
      ["natsuki", "sayori", "yuri"] 
        |> Enum.at(:rand.uniform(3)-1)
    end

    defp random_hash do
      :crypto.hash(:sha256, :rand.uniform(1000000) 
        |> Integer.to_string) 
        |> Base.encode16 
        |> String.downcase
    end

    def get_last_five do
        from(
          i in Block,
          order_by: [desc: i.inserted_at],
          limit: 5,
          select: i
        ) |> Dkexplorer.Repo.all
          |> Enum.map(fn item -> 
            %{
              hash: hash,
              miner: miner,
              size: size,
              template: template,
              tx: tx
            } = item
            %{
              hash: hash,
              miner: miner,
              size: (size / 1000),
              template: template,
              tx: tx
            }
          end)
    end

    def insert_block do
      %Block{
        hash: random_hash,
        miner: random_hash,
        size: (DkexplorerWeb.LayoutView.sentience * 1000) |> trunc,
        template: random_gril,
        tx: :rand.uniform(50)
      } |> Dkexplorer.Repo.insert
    end
end