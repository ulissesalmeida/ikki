defmodule Ikki.RoomControllerTest do
  use Ikki.ConnCase

  alias Ikki.Room
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, room_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing rooms"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, room_path(conn, :new)
    assert html_response(conn, 200) =~ "New room"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, room_path(conn, :create), room: @valid_attrs
    assert redirected_to(conn) == room_path(conn, :index)
    assert Repo.get_by(Room, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, room_path(conn, :create), room: @invalid_attrs
    assert html_response(conn, 200) =~ "New room"
  end

  test "shows chosen resource", %{conn: conn} do
    room = Repo.insert! %Room{}
    conn = get conn, room_path(conn, :show, room)
    assert html_response(conn, 200) =~ "Show room"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, room_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    room = Repo.insert! %Room{}
    conn = get conn, room_path(conn, :edit, room)
    assert html_response(conn, 200) =~ "Edit room"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    room = Repo.insert! %Room{}
    conn = put conn, room_path(conn, :update, room), room: @valid_attrs
    assert redirected_to(conn) == room_path(conn, :show, room)
    assert Repo.get_by(Room, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    room = Repo.insert! %Room{}
    conn = put conn, room_path(conn, :update, room), room: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit room"
  end

  test "deletes chosen resource", %{conn: conn} do
    room = Repo.insert! %Room{}
    conn = delete conn, room_path(conn, :delete, room)
    assert redirected_to(conn) == room_path(conn, :index)
    refute Repo.get(Room, room.id)
  end
end
