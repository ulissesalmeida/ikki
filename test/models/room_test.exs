defmodule Ikki.RoomTest do
  use Ikki.ModelCase

  alias Ikki.Room

  @valid_attrs %{name: "Java"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = build_changeset(@valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = build_changeset(@invalid_attrs)
    refute changeset.valid?
  end

  test "changeset is invalid with taken name" do
    changeset = build_changeset(@valid_attrs)
    Repo.insert!(changeset)

    new_changeset = build_changeset(@valid_attrs)

    assert {:error, invalid} = Repo.insert(new_changeset)
    assert [name: "has already been taken"] = invalid.errors
  end

  test "changeset is invalid with name too long" do
    changeset = build_changeset(%{name: String.duplicate("J", 41)})

    refute changeset.valid?
    assert [name: {error, _}] = changeset.errors
    assert Regex.match?(~r/should be at most/, error)
  end

  defp build_changeset(params) do
    Room.changeset(%Room{}, params)
  end
end
