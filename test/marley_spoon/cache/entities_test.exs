defmodule MarleySpoon.Cache.EntitiesTest do
  alias MarleySpoon.Cache.Chefs
  alias MarleySpoon.Cache.Recipes
  alias MarleySpoon.Cache.Entities
  alias MarleySpoon.Context.Chef
  alias MarleySpoon.Context.Recipe
  use MarleySpoonWeb.ConnCase
  use ExUnit.Case

  setup do
    :ok
  end

  test "returns all chefs" do
    assert Chefs.put("1", %Chef{id: "1", name: "Donald"})
    assert Chefs.put("2", %Chef{id: "2", name: "Sule"})

    assert {:ok,
            [
              %Chef{id: "1", name: "Donald"},
              %Chef{id: "2", name: "Sule"}
            ]} ==
             Entities.all_chefs()
  end

  test "returns all recipes" do
    assert Recipes.put("1", %Recipe{
             id: "1",
             chef_id: nil,
             title: "gordon's steak",
             description: "gordon's steak"
           })

    assert Recipes.put("2", %Recipe{
             id: "2",
             chef_id: nil,
             title: "panini",
             description: "this is a simple recipe"
           })

    assert {
             :ok,
             [
               %MarleySpoon.Context.Recipe{
                 id: "1",
                 chef_id: nil,
                 description: "gordon's steak",
                 title: "gordon's steak"
               },
               %MarleySpoon.Context.Recipe{
                 id: "2",
                 chef_id: nil,
                 description: "this is a simple recipe",
                 title: "panini"
               }
             ]
           } ==
             Entities.all_recipes()
  end

  test "returns assigned Chef" do
    chef_id = "1"
    recipe_id = "2"
    name = "new_name"

    assert Chefs.put(chef_id, %Chef{id: chef_id, name: name})

    assert Recipes.put(recipe_id, %Recipe{
             id: recipe_id,
             chef_id: chef_id,
             title: "my_title",
             description: "my_description"
           })

    assert {:ok, %MarleySpoon.Context.Chef{id: chef_id, name: name}} ==
             Entities.get_chef_by_recipe_id(recipe_id)
  end

  test "returns not found for recipe without assigned chef" do
    recipe_id = "2"

    assert Recipes.put(recipe_id, %Recipe{
             id: recipe_id,
             chef_id: nil,
             title: "my_title",
             description: "my_description"
           })

    assert {:ok, :not_found} ==
             Entities.get_chef_by_recipe_id(recipe_id)
  end
end
