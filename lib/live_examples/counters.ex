defmodule LiveExamples.Counters do
  alias LiveExamples.Counters.Counter

  def new, do: %{} |> add_counter

  def add_counter(counters) do
    Map.put(counters, new_key(counters), 0)
  end

  def new_key(counters) do
    counters
    |> Map.keys
    |> Enum.map(&String.to_integer/1)
    |> Enum.max
    |> Kernel.+(1)
    |> Integer.to_string

    rescue
      _e -> "1"
  end

  def inc(counters, counter_id) do
    counters
    |> Map.put(counter_id, Map.fetch!(counters, counter_id) |> Kernel.+(1) )
  end

  def dec(counters, counter_id) do
    counters
    |> Map.put(counter_id, Map.fetch!(counters, counter_id) |> Kernel.-(1) )
  end


end
