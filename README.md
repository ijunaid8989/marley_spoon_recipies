# MarleySpoon

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * MIX_ENV=prod mix release
  * ACCESS_TOKEN="7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c" ENVIRONMENT="master" SPACE_ID="kk2bw5ojx476" SECRET_KEY_BASE=`mix phx.gen.secret` _build/prod/rel/marley_spoon/bin/marley_spoon start


to test in local env.

  * config :marley_spoon, MarleySpoon.Extractor, enabled: true in config/dev.exs
  * iex -S mix phx.server