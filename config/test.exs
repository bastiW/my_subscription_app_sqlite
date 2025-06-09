import Config
config :ash, disable_async?: true

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :my_subscription_app_sqlite, MySubscriptionAppSqlite.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "my_subscription_app_sqlite_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :my_subscription_app_sqlite, MySubscriptionAppSqliteWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "1zmAqt2FNqS4XMuaEylyw/SBukgLcnrFAEzJp/iH+wtbo5c6UcF4JMi6yd3bNtL9",
  server: false

# In test we don't send emails
config :my_subscription_app_sqlite, MySubscriptionAppSqlite.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
