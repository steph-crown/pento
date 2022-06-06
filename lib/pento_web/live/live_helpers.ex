defmodule PentoWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.product_index_path(@socket, :index)}>
        <.live_component
          module={PentoWeb.ProductLive.FormComponent}
          id={@product.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.product_index_path(@socket, :index)}
          product: @product
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div
      id="modal"
      class="phx-modal fade-in flex items-end sm:items-center justify-center min-h-full p-4 text-center sm:p-0"
      phx-remove={hide_modal()}
    >
      <div
        id="modal-content"
        class="phx-modal-content fade-in-scale relative bg-white rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:max-w-lg sm:w-full sm:p-6"
        phx-click-away={JS.dispatch("click", to: "#close")}
        phx-window-keydown={JS.dispatch("click", to: "#close")}
        phx-key="escape"
      >
        <%= if @return_to do %>
          <%= live_patch("✖",
            to: @return_to,
            id: "close",
            class: "phx-modal-close",
            phx_click: hide_modal()
          ) %>
        <% else %>
          <a id="close" href="#" class="phx-modal-close" phx-click={hide_modal()}>✖</a>
        <% end %>

        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
