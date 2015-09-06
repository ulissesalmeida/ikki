defmodule Ikki.RoomChannelTest do
  use Ikki.ChannelCase

  alias Ikki.RoomChannel
  alias Ikki.Repo
  alias Ikki.Room

  setup do
    room = Repo.insert!(%Room{name: "Java"})

    {:ok, _, socket} =
      socket()
      |> subscribe_and_join(RoomChannel, "rooms:#{room.id}", %{"user" => "Anonymous 1"})

    {:ok, socket: socket, room: room}
  end

  test "join broadcasts a user has joined", %{room: room} do
    {:ok, _, socket} =
      socket()
      |> subscribe_and_join(RoomChannel, "rooms:#{room.id}", %{"user" => "Anonymous 2"})

    assert_broadcast "user:joined", %{"user": "Anonymous 2"}
  end

  test "join fails with an invalid room" do
    assert {:error, %{reason: "unauthorized"}} = socket()
      |> subscribe_and_join(RoomChannel, "rooms:1234", %{"user" => "Anonymous 2"})
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"hello" => "there"}
    assert_reply ref, :ok, %{"hello" => "there"}
  end

  test "message:new broadcasts to rooms:lobby", %{socket: socket} do
    push socket, "message:new", %{"user" => "Anonymous", "body" => "Hi!"}
    assert_broadcast "message:new", %{"user" => "Anonymous", "body" => "Hi!"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
