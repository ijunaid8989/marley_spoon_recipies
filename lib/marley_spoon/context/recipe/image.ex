defmodule MarleySpoon.Context.Image do
  use MarleySpoon.Context.Model

  @fields ~w(id url)a
  @required_fields @fields

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:url, :string)
  end

  @impl true
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
