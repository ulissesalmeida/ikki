defmodule Ikki.LayoutView do
  use Ikki.Web, :view
  import Plug.Conn, only: [get_session: 2]

  def current_user(conn) do
    get_session(conn, :user_email)
  end
end
