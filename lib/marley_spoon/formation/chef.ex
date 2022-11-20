defmodule MarleySpoon.Formation.Chef do
  @behaviour MarleySpoon.Formation.Root

  alias MarleySpoon.Cache.Chefs, as: ChefCache
  alias MarleySpoon.Context.Chef

  @impl true
  def format_and_save(term) do
    term
    |> format()
    |> validate()
    |> save()
  end

  defp format(term) do
    case term do
      %{sys: %{id: id}, fields: %{"name" => name}} -> %{id: id, name: name}
      _ -> %{}
    end
  end

  defp validate(term) do
    case Chef.validate_map(term) do
      {:ok, chef} -> chef
      _ -> :error
    end
  end

  defp save(%Chef{} = chef) do
    ChefCache.put(chef.id, chef)
  end

  defp save(_) do
    :noop
  end
end
