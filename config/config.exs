# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :dkexplorer,
  ecto_repos: [Dkexplorer.Repo]

# Configures the endpoint
config :dkexplorer, DkexplorerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jPSNiUro6j2sMT1ePwZwGu6xfwDijRS4qWWpScGFQzR5T95eThpUMsIHFufPMHP2",
  render_errors: [view: DkexplorerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Dkexplorer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  level: :info

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
