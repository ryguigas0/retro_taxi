defmodule RetroTaxi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      RetroTaxi.Repo,
      # Start the Telemetry supervisor
      RetroTaxiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RetroTaxi.PubSub},
      # Start the Endpoint (http/https)
      RetroTaxiWeb.Endpoint,
      # Start Presence
      RetroTaxiWeb.Presence
      # Start a worker by calling: RetroTaxi.Worker.start_link(arg)
      # {RetroTaxi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RetroTaxi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RetroTaxiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
