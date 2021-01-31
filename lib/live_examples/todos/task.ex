defmodule LiveExamples.Todos.Task do
  import Ecto.Changeset

  defstruct [:title, done: :false]
  @types %{title: :string, done: :boolean}

  def new, do: %__MODULE__{}

  @doc false
  def new_changeset(attrs) do
    {new(), @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required([:title, :done])
    |> validate_length(:title, min: 5, max: 20, message: "Requires length between 5-20")
  end

  def update_changeset(task, attrs) do
    task
    |> cast(attrs, [:done])
    |> validate_required([:done])
  end
end
