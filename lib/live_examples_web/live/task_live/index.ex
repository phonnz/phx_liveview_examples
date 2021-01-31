defmodule LiveExamplesWeb.TaskLive.Index do
  use LiveExamplesWeb, :live_view

  alias LiveExamples.Todos
  alias LiveExamples.Todos.Task

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
      assign(socket,
      %{
        :tasks => [],
        :done => [],
        :changeset => Todos.new_change_task(),
      })
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task")
    |> assign(:task, Todos.get_task!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tasks")
    |> assign(:task, nil)
  end

  @impl true
  def handle_event("validate", %{"task" => task_params}, socket) do
    {:noreply,
      socket
      |> assign(:changeset, Todos.new_change_task(task_params) |> Map.put(:action, :validate) )
    }
  end

  @impl true
  def handle_event("save", %{"task" => task_params}, socket) do
    {:noreply, add_task(socket, task_params) }
  end

  @impl true
  def handle_event("done", %{"id" => index}, socket) do
    {done_task, updated_tasks} = List.pop_at(socket.assigns.tasks, String.to_integer(index))
    {:noreply,
      socket
      |> assign(:tasks, updated_tasks)
      |> assign(:done, socket.assigns.done ++ [done_task])
     }
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task = Todos.get_task!(id)
    {:ok, _} = Todos.delete_task(task)

    {:noreply, socket}
  end

  defp add_task(socket, task_params) do
    if socket.assigns.changeset.valid?() do
      socket
      |> assign(:tasks, push_task(socket.assigns.tasks, task_params))
      |> assign(:changeset, Todos.new_change_task(%{}))

    else
      socket
    end
  end

  defp push_task(todos, params) do
    todos ++ [Map.put(params, "done", :false)]
  end

end
