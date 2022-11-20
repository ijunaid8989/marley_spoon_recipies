defmodule MarleySpoon.Cache.ChefsTest do
  alias MarleySpoon.Cache.Chefs
  alias MarleySpoon.Context.Chef
  use MarleySpoonWeb.ConnCase
  use ExUnit.Case

  setup do
    :ok
  end

  test "puts a chef into the cache and gets by id" do
    id = "1"
    name = "new name"

    assert Chefs.put(id, %Chef{id: id, name: name})
    assert %Chef{id: id, name: "new name"} == Chefs.get_by_id(id)
  end
end
