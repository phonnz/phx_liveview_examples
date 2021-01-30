defmodule LiveExamples.Counters.Counter do
  defstruct [:name, :count]
  @types %{:name => :string, :count => :integer}

  def new, do: __MODULE__.__struct__(name: "1", count: 0)

  def inc(counter) do
    counter
    |> Map.put(:count, Kernel.+(counter.count, 1))
  end

  def inc(counter) do
    counter
    |> Map.put(:count, Kernel.+(counter.count, 1))
  end

  def dec(counter) do
    counter
    |> Map.put(:count, decrement_count(counter.count))
  end

  defp decrement_count(value) when value > 0 do
    value |> Kernel.-(1)
  end
  defp decrement_count(value), do: 0

  def restart(counter) do
    counter
    |> Map.put(:count, 0)
  end


end
