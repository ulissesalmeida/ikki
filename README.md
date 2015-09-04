# Ikki

Ikki is a Web Chat written in Elixir using Phoenix as web framework.

To start your Ikki app:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Install the frontend dependencies with `npm install`
  4. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Managing the chat rooms

If you want manage the rooms, you need to access `/admin/rooms` path. You'll be
prompted to login, just provide the admin username and password configured on
environment config file(`config/`).

## Production

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## To learn more about Phoenix:

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## To learn more about Elixir:

  * Official website: http://elixir-lang.org/
