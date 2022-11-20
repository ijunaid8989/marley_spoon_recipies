defmodule MarleySpoonWeb.PageController do
  use MarleySpoonWeb, :controller

  alias MarleySpoon.Cache.{Entities, Recipes}

  def index(conn, _params) do
    {:ok, recipes} = Entities.all_recipes()
    render(conn, "index.html", recipes: recipes)
  end

  def show(conn, %{"id" => id} = _params) do
    recipe = Recipes.get_by_id(id)
    render(conn, "show.html", recipe: recipe)
  end
end
