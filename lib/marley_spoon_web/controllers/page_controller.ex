defmodule MarleySpoonWeb.PageController do
  use MarleySpoonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
