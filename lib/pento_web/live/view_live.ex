defmodule PentoWeb.ViewLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  # establishes the initial state for the live
  # view by populating the socket assigns
  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Guess a number")}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>

    <h2>
      <%= @message <> ": " %>
    </h2>

    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" title={"aa#{n}"} phx-click="guess" phx-value-number={n}><%= n %></a>
      <% end %>
    </h2>
    """
  end
end
