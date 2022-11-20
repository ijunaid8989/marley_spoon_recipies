defmodule MarleySpoon.Context.Recipe do
  use MarleySpoon.Context.Model

  @fields ~w(id title description chef_id tags images)a
  @required_fields @fields -- [:chef_id, :tags, :images]

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:title, :string)
    field(:description, :string)
    field(:chef_id, :string)
    field(:tags, {:array, :string})
    field(:images, {:array, :string})
  end

  @impl true
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
  end
end
