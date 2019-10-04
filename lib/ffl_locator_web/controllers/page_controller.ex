defmodule FflLocatorWeb.PageController do
  use FflLocatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
