defmodule Dkexplorer.InfoChannel do
  use DkexplorerWeb, :channel

  def join("info:top", payload, socket) do
    {:ok, socket}
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  def broadcast_top(change) do
    DkexplorerWeb.Endpoint.broadcast("info:top", "change", %{change: change})
  end

  def broadcast_block(change) do
    DkexplorerWeb.Endpoint.broadcast("info:top", "newblock", %{change: change})
  end
end
  