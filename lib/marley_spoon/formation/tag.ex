defmodule MarleySpoon.Formation.Tag do
  @behaviour MarleySpoon.Formation.Root

  alias MarleySpoon.Cache.Tags, as: TagCache
  alias MarleySpoon.Context.Tag

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
    case Tag.validate_map(term) do
      {:ok, chef} -> chef
      _ -> :error
    end
  end

  defp save(%Tag{} = chef) do
    TagCache.put(chef.id, chef)
  end

  defp save(_) do
    :noop
  end
end
