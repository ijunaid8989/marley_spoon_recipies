defmodule MarleySpoon.Context.RecipeTest do
  alias MarleySpoon.Context.Recipe

  use ExUnit.Case

  describe "Recipe" do
    setup do
      valid_attrs = %{title: "new recipe title", description: "new recipe description", id: "123"}

      {:ok, valid_attrs: valid_attrs}
    end

    test "creates a recipe with valid params", %{valid_attrs: valid_attrs} do
      valid_attrs = %{
        title: valid_attrs.title,
        description: valid_attrs.description,
        id: valid_attrs.id
      }

      assert {:ok,
              %Recipe{
                id: valid_attrs.id,
                title: valid_attrs.title,
                description: valid_attrs.description
              }} ==
               Recipe.validate_map(valid_attrs)
    end

    test "creates new recipe with valid params and chef_id", %{valid_attrs: valid_attrs} do
      chef_id = "567"

      attrs_with_chef = Map.put(valid_attrs, :chef_id, chef_id)

      assert {:ok,
              %Recipe{
                id: valid_attrs.id,
                title: valid_attrs.title,
                description: valid_attrs.description,
                chef_id: chef_id
              }} ==
               Recipe.validate_map(attrs_with_chef)
    end

    test "creates new recipe with valid params, chef_id and tags", %{valid_attrs: valid_attrs} do
      chef_id = "567"
      tags = ["567"]

      attrs_with_chef_and_tag =
        Map.put(valid_attrs, :chef_id, chef_id)
        |> Map.put(:tags, tags)

      assert {:ok,
              %Recipe{
                id: valid_attrs.id,
                title: valid_attrs.title,
                description: valid_attrs.description,
                chef_id: chef_id,
                tags: tags
              }} ==
               Recipe.validate_map(attrs_with_chef_and_tag)
    end

    test "returns error with invalid params" do
      invalid_attrs = %{}

      assert {
               :error,
               {
                 :invalid_recipe_map,
                 [
                   {:id, {"can't be blank", [validation: :required]}},
                   {:title, {"can't be blank", [validation: :required]}},
                   {:description, {"can't be blank", [validation: :required]}}
                 ]
               }
             } ==
               Recipe.validate_map(invalid_attrs)
    end
  end
end
