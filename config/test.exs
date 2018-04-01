use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dkexplorer, DkexplorerWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :dkexplorer, Dkexplorer.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "kwqoddem",
  password: "gA0jnyPn0jGPfCbaVtr3WaP5ZtzIoOLX",
  database: "kwqoddem",
  hostname: "baasu.db.elephantsql.com",
  pool_size: 1
