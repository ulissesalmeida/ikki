# Ikki

Ikki is a Open Source Web Chat written in Elixir using Phoenix as web framework.

You can see an example of the app running accessing:

[https://ikki-chat.herokuapp.com](https://ikki-chat.herokuapp.com)

To start your Ikki app in your local machine:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Install sass and compass rubies dependencies with `bundle install`
  4. Install the frontend dependencies with `npm install`
  5. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Managing the chat rooms

If you want manage the rooms, you need to access `/admin/rooms` path. You'll be
prompted to login, just provide the admin username and password configured on
environment config file(`config/`).

## Production

Today Ikki is configured to run as Heroku app. To deploy your own version of
the Ikki on Heroku you need to:

 * Add the buildpacks on the same order of the `.buildpacks` file
 * Add a postgres instance
 * Set `ADMIN_USERNAME` and `ADMIN_PASSWORD` environments

## Using this app to learn Phoenix:

If you want to learn Phoenix doing some hands-on work you can use this app
to gain knowledge and build your own version of Ikki. Just follow the instructions
on [LEARNING](LEARNING.md).

## Features roadmap:

Some ideas to evolve this app and practice Elixir/Phoenix:

* List the connected users
* Broadcast when user disconnects
* User can join multiple rooms, change the current room without leave the page
* User can mention other user with autocompletion, mentions for the current user
  are highlighted
* While user is connected in one room, he can see the number of unread messages
  in others rooms
* Emoji support
* Multiline strings on chat are considered block code
* "User is typing..." feature
* User can specify the language format of the block code
* Rooms can have a blacklist of users
* Rooms can have a whitelist of users
* User can login with a password
* User can set his visible name
* Permit users be an admin
* API for bot notifications
* Permit bot users
* Permit admin broadcast to a room in the room page
* Permit admin broadcast to all rooms in the rooms index page
* When admin manipulate the rooms broadcast to all users the CRUD modifications
  realtime
* Teams/Organizations
  * Rooms of Teams/Organizations
  * Admins of Teams/Organizations
* User can login with Facebook/Github/Google

## To learn more about Phoenix:

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## To learn more about Elixir:

  * Official website: http://elixir-lang.org/
