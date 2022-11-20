defmodule MarleySpoon.Wrapper.Request do
  @callback list_entities(term) :: {:ok, list()} | {:error, atom}

  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
