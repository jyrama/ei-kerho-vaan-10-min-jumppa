defmodule JumppaWeb.PageController do
  use JumppaWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
