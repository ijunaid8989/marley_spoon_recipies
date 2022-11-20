defmodule MarleySpoon.Context.Chef do
  import Ecto.Changeset

  use MarleySpoon.Context.Model

  @required_fields ~w(name id)a

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:id, :string)
  end

  @impl true
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
