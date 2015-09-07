defmodule Ikki.ChatControllerTest do
  use Ikki.ConnCase

  test "GET /chat renders chat application" do
    conn = conn()
      |> post("/session", [email: "java@mail.com"])
      |> get("/chat")

    assert html_response(conn, 200) =~ "Rooms"
  end

  test "GET /chat requires a authenticated user" do
    conn = conn()
      |> get("/chat")

    assert "/" = redirected_to(conn)
  end
end
