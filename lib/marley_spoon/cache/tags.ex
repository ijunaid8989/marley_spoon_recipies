defmodule MarleySpoon.Cache.Tags do
  @moduledoc """
  chefs in ets for access.
  """
  use GenServer

  @t :tags

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

  @spec all() :: list()
  def all() do
    :ets.tab2list(@t) |> Enum.map(fn {_key, value} -> value end)
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

  @spec put(binary(), map()) :: boolean()
  def put(key, %MarleySpoon.Context.Tag{} = chef) do
    :ets.insert(@t, {key, chef})
  end
end
