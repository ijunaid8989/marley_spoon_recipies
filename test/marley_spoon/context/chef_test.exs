defmodule MarleySpoon.Context.ChefTest do
  alias MarleySpoon.Context.Chef

  use ExUnit.Case

  describe "Chef" do
    test "creates chef with valid params" do
      name = "new_chef"
      id = "123"

      valid_attrs = %{name: name, id: id}

      assert {:ok, %Chef{id: id, name: name}} == Chef.validate_map(valid_attrs)
    end

    test "returns error with invalid params" do
      invalid_attrs = %{}

      assert {
               :error,
               {
                 :invalid_chef_map,
                 [
                   {:name, {"can't be blank", [validation: :required]}},
                   {:id, {"can't be blank", [validation: :required]}}
                 ]
               }
             } ==
               Chef.validate_map(invalid_attrs)
    end
  end
end
