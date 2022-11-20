defmodule MarleySpoon.Context.TagTest do
  alias MarleySpoon.Context.Tag

  use ExUnit.Case

  describe "Tag" do
    test "creates tag with valid params" do
      name = "new tag"
      id = "123"

      valid_attrs = %{name: name, id: id}

      assert {:ok, %Tag{id: id, name: name}} == Tag.validate_map(valid_attrs)
    end

    test "returns error with invalid params" do
      invalid_attrs = %{}

      assert {
               :error,
               {
                 :invalid_tag_map,
                 [
                   {:name, {"can't be blank", [validation: :required]}},
                   {:id, {"can't be blank", [validation: :required]}}
                 ]
               }
             } ==
               Tag.validate_map(invalid_attrs)
    end
  end
end
