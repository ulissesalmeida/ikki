defmodule Ikki.RoomChannelTest do
  use Ikki.ChannelCase

  alias Ikki.RoomChannel
  alias Ikki.Repo
  alias Ikki.Room

  @authenticated_user %{id: "java_user@java.com", name: "java_user" }

  setup do
    room = Repo.insert!(%Room{name: "Java"})

    {:ok, _, socket} =
      socket("users_socket:java_user@java.com", %{user: @authenticated_user})
        |> subscribe_and_join(RoomChannel, "rooms:#{room.id}")

    {:ok, socket: socket, room: room}
  end

  test "join broadcasts a user has joined", %{room: room} do
    {:ok, _, socket} =
      socket("users_socket:java_user@java.com", %{user: @authenticated_user})
        |> subscribe_and_join(RoomChannel, "rooms:#{room.id}")

    assert_broadcast "user:joined", %{user: @authenticated_user}
  end

  test "join fails with an invalid room" do
    assert {:error, %{reason: "unauthorized"}} =
      socket("users_socket:java_user@java.com", %{user: @authenticated_user})
        |> subscribe_and_join(RoomChannel, "rooms:1234")
  end

  test "join fails without an user", %{room: room} do
    assert {:error, %{reason: "unauthorized"}} =
      socket()
        |> subscribe_and_join(RoomChannel, "rooms:#{room.id}")
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "message:new broadcasts to rooms:lobby", %{socket: socket} do
    push socket, "message:new", %{"body" => "Hi!"}
    assert_broadcast "message:new", %{body: "Hi!", user: @authenticated_user}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
