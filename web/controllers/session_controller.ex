defmodule Ikki.SessionController do
  use Ikki.Web, :controller

  def new(conn, _params) do
    if get_session(conn, :user_email) do
      redirect conn, to: chat_path(conn, :index)
    else
      render conn, "index.html"
    end
  end

  def signin(conn, %{"email" => email}) do
    conn
      |> put_session(:user_email, email)
      |> redirect(to: chat_path(conn, :index))
  end

  def signout(conn, _params) do
    conn
      |> put_session(:user_email, nil)
      |> redirect(to: "/")
  end
end
