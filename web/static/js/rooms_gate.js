import ChatRoom from "./chat_room"

class RoomsGate {
  constructor({socket: socket, user: user, roomsList: roomsList, chatView: chatView}) {
    this.socket = socket
    this.user = user
    this.roomsList = roomsList
    this.chatView = chatView

    this.bindEvents()
  }

  bindEvents() {
    this.roomsList.on('click', 'a', this.selectRoom.bind(this))
  }

  selectRoom(event) {
    let roomLink = $(event.target)
    let roomData = roomLink.data('room')

    event.preventDefault()
    this.roomsList.slideUp()
    this.joinRoom(roomData)
  }

  joinRoom(roomData) {
    let room = new ChatRoom({ room: roomData, socket: this.socket, user: this.user, context: this.chatView })
    this.socket.connect({token: window.userToken})
    room.connect()
    this.chatView.removeClass('hidden')
  }
}

export default RoomsGate
