defmodule MarleySpoon.Formation.Recipe do
  @behaviour MarleySpoon.Formation.Root

  alias MarleySpoon.Cache.Recipes, as: RecipeCache
  alias MarleySpoon.Context.Recipe

  @impl true
  def format_and_save(term) do
    term
    |> format()
    |> validate()
    |> save()
  end

  defp format(term) do
    case term do
      %{
        sys: %{id: id},
        assets: assets,
        fields:
          %{
            "description" => description,
            "title" => title
          } = fields
      } ->
        %{
          id: id,
          description: description,
          title: title,
          images: parse_images(assets),
          tags: parse_tags(fields),
          chef_id: add_chef_id(fields)
        }

      _ ->
        %{}
    end
  end

  defp validate(term) do
    case Recipe.validate_map(term) do
      {:ok, recipe} -> recipe
      _ -> :error
    end
  end

  defp save(%Recipe{} = recipe) do
    RecipeCache.put(recipe.id, recipe)
  end

  defp save(_) do
    :noop
  end

  defp add_chef_id(%{
         "chef" => %{
           "sys" => %{
             "id" => chef_id
           }
         }
       }),
       do: chef_id

  defp add_chef_id(_not_a_chef), do: nil

  defp parse_images(assets) do
    Enum.reduce(assets, [], fn asset, acc ->
      %{
        fields: %{
          file: %{
            content_type: content_type,
            url: %{
              host: host,
              path: path
            }
          }
        }
      } = asset

      case content_type do
        "image/jpeg" ->
          ["https://" <> host <> path | acc]

        _ ->
          acc
      end
    end)
  end

  defp parse_tags(%{"tags" => tags}) do
    Enum.map(tags, fn tag ->
      %{
        "sys" => %{
          "id" => id
        }
      } = tag

      id
    end)
  end

  defp parse_tags(_not_a_tag), do: nil
end
