defmodule MarleySpoon.Cache.Entities do
  alias MarleySpoon.Cache.{Chefs, Recipes, Tags}

  @spec get_chef_by_recipe_id(binary()) :: {:ok, Chefs} | {:error, :not_found}
  def get_chef_by_recipe_id(id) do
    case MarleySpoon.Cache.Recipes.get_by_id(id) do
      %{chef_id: chef_id} -> {:ok, Chefs.get_by_id(chef_id)}
      _ -> {:error, :not_found}
    end
  end

  def get_tags_by_recipe_id(id) do
    case MarleySpoon.Cache.Recipes.get_by_id(id) do
      %{tags: tags} -> {:ok, Enum.map(tags, &Tags.get_by_id(&1))}
      _ -> {:error, :not_found}
    end
  end

  @spec all_recipes() :: list(Recipes)
  def all_recipes(), do: {:ok, Recipes.all()}

  @spec all_chefs() :: list(Chefs)
  def all_chefs(), do: {:ok, Chefs.all()}
end
