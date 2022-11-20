defmodule MarleySpoon.Cache.Recipes do
  @moduledoc """
  recipes in ets for access.
  """
  use GenServer

  alias MarleySpoon.Cache.{Chefs, Tags}

  @t :recipes

  def init(arg) do
    :ets.new(@t, [
      :set,
      :public,
      :named_table,
      {:read_concurrency, true},
      {:write_concurrency, true}
    ])

    {:ok, arg}
  end

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @spec get_by_id(binary()) :: binary() | :not_found
  def get_by_id(id) do
    case :ets.lookup(@t, id) do
      [] ->
        :not_found

      [{_key, value}] ->
        recipe(value)
    end
  end

  @spec all() :: list()
  def all() do
    :ets.tab2list(@t)
    |> Enum.reduce([], fn(recipe, acc) ->
      {_id, meta_data} = recipe
      [recipe(meta_data) | acc]
    end)
  end

  @spec put(binary(), map()) :: boolean()
  def put(key, %MarleySpoon.Context.Recipe{} = recipe) do
    :ets.insert(@t, {key, recipe})
  end

  defp merge_chef(nil), do: nil

  defp merge_chef(chef_id) do
    Chefs.get_by_id(chef_id).name
  end

  defp merge_tags(nil), do: []

  defp merge_tags(tags) do
    Enum.map(tags, &Tags.get_by_id(&1).name)
  end

  defp recipe(meta_data) do
    %{
      chef: merge_chef(meta_data.chef_id),
      description: meta_data.description,
      id: meta_data.id,
      images: meta_data.images,
      tags: merge_tags(meta_data.tags),
      title: meta_data.title
    }
  end
end
