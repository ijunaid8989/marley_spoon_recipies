defmodule MarleySpoon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MarleySpoonWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: MarleySpoon.PubSub},
      # Start the Endpoint (http/https)
      MarleySpoonWeb.Endpoint,
      MarleySpoon.Cache.Chefs,
      MarleySpoon.Cache.Recipes,
      MarleySpoon.Cache.Tags,
      MarleySpoon.Extractor
      # Start a worker by calling: MarleySpoon.Worker.start_link(arg)
      # {MarleySpoon.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MarleySpoon.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MarleySpoonWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
