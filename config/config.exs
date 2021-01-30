# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_examples,
  ecto_repos: [LiveExamples.Repo]

# Configures the endpoint
config :live_examples, LiveExamplesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yJ8VIzhDFBaiISIPNYkDQGK0ckyXIYzgDq0XKnPZqMo1HrqaTCkzGN8UZqOkpfgE",
  render_errors: [view: LiveExamplesWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiveExamples.PubSub,
  live_view: [signing_salt: "IFNJ+RBt"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
