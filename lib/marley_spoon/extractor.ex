defmodule MarleySpoon.Extractor do
  @moduledoc """
  Request and Extract recipes, tags and chefs for MarleySpoon Contentful
  """

  use GenServer
  alias MarleySpoon.Gordan

  require Logger

  @interval 60_000
  @entities_to_extract [:tag, :chef, :recipe]

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def init(_) do
    :timer.send_interval(@interval, :tick)

    {:ok, 0, {:continue, :put_to_work}}
  end

  def handle_continue(put_to_work, state) do
    work()

    {:noreply, state}
  end

  def handle_info(:tick, state) do
    if Application.get_env(:marley_spoon, __MODULE__)[:enabled], do: work()

    {:noreply, state}
  end

  defp work do
    {:ok, count} = Gordan.mixing(@entities_to_extract)
    Logger.debug("#{count} entities updated.")
  end
end
