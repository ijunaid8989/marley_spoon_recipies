defmodule MarleySpoon.Request.Contentful do
  import Contentful.Query
  use MarleySpoon.Wrapper.Request

  alias Contentful.Delivery.Entries

  @error {:error, :listing_failed}

  @impl true
  def list_entities(content_type) when is_atom(content_type) do
    content_type
    |> Atom.to_string()
    |> do_list_entities()
  end

  defp do_list_entities(type) do
    try do
      Entries
      |> content_type(type)
      |> fetch_all()
      |> case do
        {:ok, entries, _} ->
          entries

        _ ->
          @error
      end
    rescue
      _e -> @error
    end
  end
end
