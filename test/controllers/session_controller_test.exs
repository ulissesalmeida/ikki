defmodule Ikki.SessionControllerTest do
  use Ikki.ConnCase

  test "GET /" do
    conn = get conn(), "/"

    assert html_response(conn, 200) =~ "Welcome!"
  end

  test "authenticated GET / redirects to chat" do
    conn = conn()
      |> post("/session", [email: "java@mail.com"])
      |> get("/")

    assert "/chat" = redirected_to(conn)
  end

  test "POST /session authenticates user" do
    conn = conn()
      |> post("/session", [email: "java@mail.com"])

    assert "/chat" = redirected_to(conn)

    conn = get conn, "/chat"
    assert html_response(conn, 200) =~ "java@mail.com"
  end

  test "DELETE /session unauthenticate user" do
    conn = conn()
      |> post("/session", [email: "java@mail.com"])
      |> delete("/session")

    assert "/" = redirected_to(conn)

    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome"
  end
end
