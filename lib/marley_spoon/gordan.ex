defmodule MarleySpoon.Gordan do
  @doc """
  Gordan module is named after Gordon Ramsey, it will mix it up everything and brings on recipes as well as Chefs and tags.
  """
  require Logger
  import MarleySpoon.Request.Contentful, only: [list_entities: 1]

  @spec mixing(list()) :: {:ok, non_neg_integer}
  def mixing(types) do
    inserted =
      types
      |> Enum.map(fn type -> {formation(type), list_entities(type)} end)
      |> Enum.map(fn {formation, entries} -> entries |> Enum.map(&formation.format_and_save/1) end)
      |> List.flatten()
      |> Enum.count()

    {:ok, inserted}
  end

  defp formation(type) do
    case type do
      :chef -> MarleySpoon.Formation.Chef
      :recipe -> MarleySpoon.Formation.Recipe
      :tag -> MarleySpoon.Formation.Tag
    end
  end
end
