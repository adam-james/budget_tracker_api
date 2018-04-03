# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :budget_tracker_api,
  ecto_repos: [BudgetTracker.Repo]

# Configures the endpoint
config :budget_tracker_api, BudgetTrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Cwz1FQmYBUSNG93DyqH6wgNcllDjtme1i/2GXHl/BNAT4T2KA3tkbyVuP5WYTYWs",
  render_errors: [view: BudgetTrackerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BudgetTracker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
