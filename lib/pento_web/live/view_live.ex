defmodule PentoWeb.ViewLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  # establishes the initial state for the live
  # view by populating the socket assigns
  def mount(_params, session, socket) do
    {:ok,
     assign(socket,
       score: 0,
       message: "Guess a number",
       time: getTime(),
       correct_guess: :rand.uniform(10),

       #  Adds session id and current user to state
       session_id: session["live_socket_id"]
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %></h1>
    <p>Hello <%= @current_user.email %></p>
    <p>User session <%= @session_id %></p>
    <p><%= @correct_guess %></p>

    <p>Game ends when score is 10</p>

    <h2>
      <%= @message <> ": " %>
    </h2>

    <p>
      <%= @time %>
    </p>

    <%= if @score == 10 do %>
      <p>
        You win!
      </p>

      <button phx-click="restart">
        Restart
      </button>
    <% end %>

    <%= if @score < 10 do %>
      <h2>
        <%= for n <- 1..10 do %>
          <!-- phx-click is a click handler and "guess" is the click message -->
        <!-- phx-value-{var_name}={value} : {var_name: value} will be the data that will passed to the handle_event function. It's a param  -->
          <a href="#" title={"aa#{n}"} phx-click="guess" phx-value-number={n} phx-value-style="ii">
            <%= n %>
          </a>
        <% end %>
      </h2>
    <% end %>
    """
  end

  #   Gets the current time
  def getTime do
    DateTime.utc_now() |> to_string
  end

  #  A handle event function
  #   `guess` is the message name for the event
  def handle_event("guess", %{"number" => guess} = _data, socket) do
    {value, _} = Integer.parse(guess)

    if value != socket.assigns.correct_guess do
      message = "Your guess: #{guess}. Wrong. Guess again. "
      score = socket.assigns.score - 1

      {
        :noreply,
        assign(
          socket,
          message: message,
          score: score
        )
      }
    else
      score = socket.assigns.score + 1

      if score == 10 do
        message = "Your guess: #{guess}. Correct. Game over. "
        score = socket.assigns.score + 1

        {
          :noreply,
          assign(
            socket,
            message: message,
            score: score
          )
        }
      else
        message = "Your guess: #{guess}. Correct. Guess again. "

        {
          :noreply,
          assign(
            socket,
            message: message,
            score: score,
            correct_guess: :rand.uniform(10)
          )
        }
      end
    end
  end

  def handle_event("restart", _, socket) do
    {
      :noreply,
      assign(
        socket,
        message: "Guess a number",
        time: getTime(),
        correct_guess: :rand.uniform(10),
        score: 0
      )
    }
  end
end
