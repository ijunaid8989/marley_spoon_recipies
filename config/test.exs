import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :marley_spoon, MarleySpoonWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "nYjrA5RA7MelFbjnDQoPhLzieLE9zBu/fHrdQ23Wg8v+Z/XVCJDj7B3Gci7L/w8C",
  server: false

# In test we don't send emails.
config :marley_spoon, MarleySpoon.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :marley_spoon, MarleySpoon.Extractor, enabled: false
