# Learning Phoenix while creating a Chat app

For me is always cool learn new languages and framework, but is even better
learning it while building a real application. In this guide you can

## Install the app dependencies

All these cools names you need to find out how to install in your system: node,
elixir, phoenix, and postgres. Install ruby only if you want work with the ruby
sass version.

## Clone or fork the repository

You need have your own version of Ikki source code. :)

## Step-00

`git checkout -b step-00`

You'll get initial version of the repo. Your first exercise here is:

* Create pages to CRUD the chat rooms. These rooms later will be used by users
to chat.
* These rooms only be created by an admin.
* The admin username/password must be configurable.

### Tips:

 * You don't need to worry about creating table for admin users now.
 * Phoenix generators are your friends.

You can see my solution [here](https://github.com/ulissesalmeida/ikki/compare/step-00...step-01).

## Step-01

`git checkout -b step-01`

Here you already the admin section done. Now is time to build the first draft
of the chat:

* Create a channel with a default room that everyone have access.
* When someone enter in the room everyone receives a message.
* When someone send a message, everyone receives.

### Tips:

* You don't need to worry about creating table for users now.
* Phoenix generators are your friends.

You can see my solution [here](https://github.com/ulissesalmeida/ikki/compare/step-01...step-02).

## Step-02

`git checkout -b step-02`

Here you already have the first draft of the chat and a admin section to create
rooms. Now is time to make users enter in the configured rooms:

* List the rooms for user, now he can select one to enter.
* Build the channel to validate the selected room and make users join them.

You can see my solution [here](https://github.com/ulissesalmeida/ikki/compare/step-02...step-03).

## Step-03

`git checkout -b step-03`

Here you have user connecting the rooms, but they are anonymous, let's fix that.
Now is time to make users provide some information and make that information
persistent:

* Make a page that user enter their e-mail.
* Create a socket connection with token and the make the channel connection
be persistent to that e-mail.(You don't need pass any information about the
current user while sending messages)

### Tips:

* You don't need to worry now about creating a users table or passwords.

You can see my solution [here](https://github.com/ulissesalmeida/ikki/compare/step-03...step-04).

## Step-04

Congratulations, you've reached the master application features! \o/ If you want
to more features to develop and expand your Elixir and Phoenix knowledge you check
it out the features roadmap on [README](README.md) file to inspire you.
