defmodule PentoWeb.HelloController do
  use PentoWeb, :controller

  def index(conn, _params) do
    IO.inspect(conn.request_path)
    render(conn, "pol.html")
  end
end
