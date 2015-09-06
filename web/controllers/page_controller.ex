defmodule Ikki.PageController do
  use Ikki.Web, :controller
  alias Ikki.Room

  def index(conn, _params) do
    rooms = Repo.all(Room)
    render conn, "index.html", rooms: rooms
  end
end
