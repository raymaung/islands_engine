defmodule IslandsEngine.Island do

  alias IslandsEngine.Island
  alias IslandsEngine.Coordinate

  def start_link() do
    Agent.start_link(fn -> [] end)
  end

  def replace_coordinates(island, new_coordinates) do
    Agent.update(island, fn _state -> new_coordinates end)
  end

  def forested?(island) do
    island
    |> get_state
    |> Enum.all?(fn coord -> Coordinate.hit?(coord) end)
  end

  def to_string(island) do
    "[" <> coordinate_strings(island) <> "]"
  end

  defp coordinate_strings(island) do
    island
    |> get_state
    |> Enum.map(fn coord -> Coordinate.to_string(coord) end)
    |> Enum.join(", ")
  end

  defp get_state(island) do
    island
    |> Agent.get(fn state -> state end)
  end
end