defmodule PentoWeb.HelloController do
  use PentoWeb, :controller

  def index(conn, _params) do
    render(conn, "pol.html")
  end
end
