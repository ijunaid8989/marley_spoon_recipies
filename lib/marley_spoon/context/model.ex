defmodule MarleySpoon.Context.Model do
  @callback from_map(map) :: {:ok, struct} | {:error, {atom, [keyword()]}}
  @callback changeset(map) :: Ecto.Changeset.t()

  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
      use Ecto.Schema
      import Ecto.Changeset

      @type t :: %__MODULE__{}

      @model_type __MODULE__
                  |> Module.split()
                  |> List.last()
                  |> Macro.underscore()
                  |> String.to_atom()

      @invalid_key :"invalid_#{@model_type}_map"

      @impl MarleySpoon.Context.Model
      def from_map(map) when is_map(map) do
        case apply_action(changeset(map), :insert) do
          {:error, changeset} ->
            {:error, {@invalid_key, changeset.errors}}

          {:ok, t} ->
            {:ok, t}
        end
      end
    end
  end
end
