defmodule Ikki.ChatController do
  use Ikki.Web, :controller
  alias Ikki.Room

  plug :require_user
  plug :put_user_token

  def index(conn, _params) do
    rooms = Repo.all(Room)
    render conn, "index.html", rooms: rooms
  end

  defp require_user(conn, _params) do
    case get_session(conn, :user_email) do
      nil ->
        conn
          |> put_flash(:info, "Not authenticated yet. Please provide your e-mail.")
          |> redirect(to: "/")
          |> halt
      email ->
        assign(conn, :current_user, email)
    end
  end

  defp put_user_token(conn, _) do
    current_user = get_session(conn, :user_email)
    token = Phoenix.Token.sign(conn, "user", current_user)
    assign(conn, :user_token, token)
  end
end
