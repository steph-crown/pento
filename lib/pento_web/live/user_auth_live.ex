defmodule PentoWeb.UserAuthLive do
  import Phoenix.LiveView
  alias Pento.Accounts

  # Just like componentDidMount
  def on_mount(_, _params, %{"user_token" => user_token}, socket) do
    # Gets user by session token
    user = Accounts.get_user_by_session_token(user_token)

    # assigns current user to socket
    socket =
      socket
      |> assign(:current_user, user)

    # If authenticated,
    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/login")}
    end
  end
end
