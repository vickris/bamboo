# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bamboo_company,
  ecto_repos: [BambooCompany.Repo]

# Configures the endpoint
config :bamboo_company, BambooCompanyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "h+VEG+yp1AvvuMKjG01KRcDVHGEs02fYlihkr5ZOf4H8V7SAtMOn+5BQnuMEJX38",
  render_errors: [view: BambooCompanyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BambooCompany.PubSub,
  live_view: [signing_salt: "DsChpv1G"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
