# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :jumppa,
  ecto_repos: [Jumppa.Repo]

# Configures the endpoint
config :jumppa, JumppaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fBGQNTjiSU9cIl8G7ijYBjU9/q4Ma5c/NadUvhNSfPZxl3uhudFo51/0vbhbxfnF",
  render_errors: [view: JumppaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Jumppa.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
