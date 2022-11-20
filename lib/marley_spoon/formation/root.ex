defmodule MarleySpoon.Formation.Root do
  @callback format_and_save(map) :: :ok | {:error, atom}
end
