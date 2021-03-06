defmodule Ikki.RoomChannel do
  use Ikki.Web, :channel
  alias Ikki.Room
  alias Ikki.Repo

  def join("rooms:" <> roomId, _params, socket) do
    if authorized?(socket, roomId) do
      send(self, :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic.
  def handle_in("message:new", %{"body" => message}, socket) do
    broadcast socket, "message:new", %{body: message, user: socket.assigns[:user]}
    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  # The `push` and `broadcast` can only be called after the socket has finished joining.
  # To push a message on join, send to self and handle in handle_info/2
  def handle_info(:after_join, socket) do
    broadcast! socket, "user:joined", %{user: socket.assigns[:user]}
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(socket, roomId) do
    Repo.get(Room, roomId) && socket.assigns[:user]
  end
end
