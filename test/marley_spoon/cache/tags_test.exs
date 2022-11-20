defmodule MarleySpoon.Cache.TagsTest do
  alias MarleySpoon.Cache.Tags
  alias MarleySpoon.Context.Tag
  use MarleySpoonWeb.ConnCase
  use ExUnit.Case

  setup do
    :ok
  end

  test "puts a tag into the cache and gets by id" do
    id = "1"
    name = "new tag name"

    assert Tags.put(id, %Tag{id: id, name: name})
    assert %Tag{id: id, name: "new tag name"} == Tags.get_by_id(id)
  end
end
