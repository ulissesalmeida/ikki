defmodule Ikki.PageController do
  use Ikki.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
