defmodule MarleySpoon.Cache.Recipes do
  @moduledoc """
  recipes in ets for access.
  """
  use GenServer

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
        value
    end
  end

  @spec all() :: list()
  def all() do
    :ets.tab2list(@t) |> Enum.map(fn {_key, value} -> value end)
  end

  @spec put(binary(), map()) :: boolean()
  def put(key, %MarleySpoon.Context.Recipe{} = recipe) do
    :ets.insert(@t, {key, recipe})
  end
end
