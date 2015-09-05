defmodule Ikki.PageControllerTest do
  use Ikki.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Ikki"
  end
end
