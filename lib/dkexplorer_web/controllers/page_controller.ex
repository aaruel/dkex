defmodule DkexplorerWeb.PageController do
  use DkexplorerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
