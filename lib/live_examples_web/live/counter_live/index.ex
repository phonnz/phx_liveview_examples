defmodule LiveExamplesWeb.CounterLive do
  use LiveExamplesWeb, :live_view

  alias LiveExamples.Counters
  # alias LiveExamples.Counters.Counter

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :counters, Counters.new() )}
  end

  # @impl true
  # def handle_params(params, _url, socket) do
  #   {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  # end

  def render(assigns) do
    ~L"""
    <h2>Counters</h2>
    <%= for {name, value} <- @counters do %>
      <p> Counter <%= name %></p>
      <p><button phx-click="dec" value="<%= name %>">-</button><%= value %><button phx-click="inc" value="<%= name %>"> + </button> </p>
      <% end %>
    <button phx-click="add-counter" >Add Counter</button>
          <div class="ui divider"></div>
      """
      # <span><%= live_patch "Add Counter", to: Routes.live_path(@socket, :add_counter) %></span>
  end

  # defp apply_action(socket, :edit, %{"id" => id}) do
  #   socket
  #   |> assign(:page_title, "Edit Counter")
  #   |> assign(:counter, %{})
  # end

  defp apply_action(socket, :add_counter, _params) do
    socket
    |> assign(:counters, add_counter(socket.assigns.counter))
  end

  # defp apply_action(socket, :index, _params) do
  #   socket
  #   |> assign(:page_title, "Listing Counters")
  # end

  def handle_event("add-counter", _, socket) do
    {:noreply,
      socket
      |> assign(:counters, add_counter(socket.assigns.counters))
    }
  end

  def handle_event("inc", %{"value" => counter_id}, socket) do
    {:noreply,
      socket
      |> assign(:counters, Counters.inc(socket.assigns.counters, counter_id))
    }
  end

  def handle_event("dec", %{"value" => counter_id}, socket) do
    {:noreply,
      socket
      |> assign(:counters, Counters.dec(socket.assigns.counters, counter_id))
    }
  end



  defp add_counter(counters) do
    Counters.add_counter(counters)
  end
end
