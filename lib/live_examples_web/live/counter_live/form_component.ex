defmodule LiveExamplesWeb.CounterLive.FormComponent do
  use LiveExamplesWeb, :live_component

  alias LiveExamples.Counters

  @impl true
  def update(%{counter: counter} = assigns, socket) do
    changeset = Counters.change_counter(counter)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"counter" => counter_params}, socket) do
    changeset =
      socket.assigns.counter
      |> Counters.change_counter(counter_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"counter" => counter_params}, socket) do
    save_counter(socket, socket.assigns.action, counter_params)
  end

  defp save_counter(socket, :edit, counter_params) do
    case Counters.update_counter(socket.assigns.counter, counter_params) do
      {:ok, _counter} ->
        {:noreply,
         socket
         |> put_flash(:info, "Counter updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_counter(socket, :new, counter_params) do
    case Counters.create_counter(counter_params) do
      {:ok, _counter} ->
        {:noreply,
         socket
         |> put_flash(:info, "Counter created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
