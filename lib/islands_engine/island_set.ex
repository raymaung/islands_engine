defmodule IslandsEngine.IslandSet do
  alias IslandsEngine.IslandSet
  alias IslandsEngine.Island

  defstruct [
    atoll: :none,
    dot: :none,
    l_shape: :none,
    s_shape: :none,
    square: :none
  ]

  def start_link() do
    Agent.start_link(fn -> initialized_set() end)
  end

  def to_string(island_set) do
    "%IslandSet{"<> string_body(island_set) <> "}"
  end


  defp initialized_set() do
    Enum.reduce(keys(), %IslandSet{}, fn key, set ->
      {:ok, island} = Island.start_link()
      Map.put(set, key, island)
    end)
  end

  defp keys() do
    %IslandSet{}
    |> Map.from_struct
    |> Map.keys
  end

  defp string_body(island_set) do
    Enum.reduce(keys(), "", fn key, acc ->
      island = get_island(island_set, key)
      acc <> "#{key} => " <> Island.to_string(island) <> "\n"
    end)
  end

  defp get_island(island_set, island_type) do
    island_set
    |> Agent.get(fn island_set -> Map.fetch!(island_set, island_type) end)
  end
end