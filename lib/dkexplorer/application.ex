defmodule Dkexplorer.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Dkexplorer.Repo, []),
      # Start the endpoint when the application starts
      supervisor(DkexplorerWeb.Endpoint, []),
      # Start your own worker by calling: Dkexplorer.Worker.start_link(arg1, arg2, arg3)
      # worker(Dkexplorer.Worker, [arg1, arg2, arg3]),
      worker(Dkexplorer.Schedule, [])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dkexplorer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DkexplorerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule Dkexplorer.Schedule do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    schedule_new_block()
    {:ok, state}
  end

  def handle_info(:newblock, state) do
    Dkexplorer.Info.Query.insert_new_block
    Dkexplorer.Block.Query.insert_block
    Dkexplorer.Block.Query.get_last_five
        |> Dkexplorer.InfoChannel.broadcast_block
    schedule_new_block()
    {:noreply, state}
  end

  def handle_info(:work, state) do
    {:ok, %Dkexplorer.Info{
      aitemplates: ait,
      hashrate: hr
    }} = Dkexplorer.Info.Query.insert_info
    %{
      aitemplates: ait, 
      hashrate: hr, 
      sentience: DkexplorerWeb.LayoutView.sentience
    } |> Dkexplorer.InfoChannel.broadcast_top
    ###
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 5 * 1000) # 5 seconds
  end

  defp schedule_new_block() do
    Process.send_after(self(), :newblock, 5 * 60 * 1000) # 5 minutes
  end
end