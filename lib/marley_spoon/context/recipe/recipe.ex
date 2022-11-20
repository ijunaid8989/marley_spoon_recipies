defmodule MarleySpoon.Context.Recipe do
  use MarleySpoon.Context.Model

  alias MarleySpoon.Context.Image

  @fields ~w(id title description chef_id)a
  @required_fields @fields -- [:chef_id]

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:title, :string)
    field(:description, :string)
    field(:chef_id, :string)
    embeds_many :images, Image
  end

  @impl true
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @fields)
    |> cast_embed(:images, required: false)
    |> validate_required(@required_fields)
  end
end
