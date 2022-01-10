defmodule BambooCompany.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BambooCompany.Repo,
      # Start the Telemetry supervisor
      BambooCompanyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BambooCompany.PubSub},
      # Start the Endpoint (http/https)
      BambooCompanyWeb.Endpoint,
      # Start a worker by calling: BambooCompany.Worker.start_link(arg)
      # {BambooCompany.Worker, arg}
      # Start the querying service
      # BambooCompany.QueryingService
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BambooCompany.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BambooCompanyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
