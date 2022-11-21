# MarleySpoon

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * MIX_ENV=prod mix release
  * ACCESS_TOKEN="7ac531648a1b5e1dab6c18b0979f822a5aad0fe5f1109829b8a197eb2be4b84c" ENVIRONMENT="master" SPACE_ID="kk2bw5ojx476" SECRET_KEY_BASE=`mix phx.gen.secret` _build/prod/rel/marley_spoon/bin/marley_spoon start


to test in local env.

  * `config :marley_spoon, MarleySpoon.Extractor, enabled: true` in config/dev.exs
  * `iex -S mix phx.server`


## Summary

The whole application has 3 main parts
  * Cache module, which is responsible of saving and serving the Chefs, Tags, and Recipes.
  * Context module, which is holding all the structs for Chefs, Tags and Recipes.
  * Fromation module, this will accept data from contenful api and format it to what we can save in ETS cache system from point 1.
  * 3 Cache states have been added to deal with tags, chefs and recipes.
  * A module Gordon (Ramsey, due to chef and recipe stuff) has been added to fetch data from contentful and format it to useful.
  * an extractor has been added which will run every minute to bring updated data from contentful.
  * in page controller the index and show are the views which were asked in task description.
  * Production ready is somehow working but my time is up if I would have more time then
    - I would switch to Redis instead of ETS to keep Cache.
    - Add Docker for deployment.
    - Work more on the front end part.
