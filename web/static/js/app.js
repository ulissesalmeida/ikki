// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "deps/phoenix_html/web/static/js/phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".
import socket from "./socket"
import RoomsGate from "./rooms_gate"

$(function() {
  let chatView = $('[data-chat]')
  let roomsList = $('[data-rooms]')

  if (roomsList.length) {
    socket.connect({token: window.userToken})
    new RoomsGate({socket: socket, roomsList: roomsList, chatView: chatView})
  }
})
