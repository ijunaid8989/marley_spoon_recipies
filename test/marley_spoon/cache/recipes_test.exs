defmodule MarleySpoon.Cache.RecipesTest do
  alias MarleySpoon.Cache.Recipes
  alias MarleySpoon.Context.Recipe
  use MarleySpoonWeb.ConnCase
  use ExUnit.Case

  setup do
    :ok
  end

  test "puts a recipe into the cache and gets by id" do
    id = "1"
    title = "new title"
    description = "new description"

    assert Recipes.put(id, %Recipe{title: title, description: description, id: id})
    assert %Recipe{id: id, description: description, title: title} == Recipes.get_by_id(id)
  end
end
