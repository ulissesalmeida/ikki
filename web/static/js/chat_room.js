const ENTER = 13
const EMPTY = ""

class ChatRoom {
  constructor({room: room, socket: socket, context: context}) {
    this.room = room
    this.channel = socket.channel(`rooms:${room.id}`)
    this.chatTitle = context.find('[data-room-name]')
    this.chatInput  = context.find('[data-chat-input]')
    this.chatForm = context.find('[data-chat-form]')
    this.messagesBoard = context.find('[data-chat-messages]')
    this.usersList = context.find('[data-chat-users]')

    this.bindEvents()
  }

  connect() {
    this.channel.join()
      .receive('ok', _payload => this.chatTitle.text(this.room.name) )
      .receive('error', error => console.log("Unabled to join", error))
  }

  bindEvents() {
    this.chatInput.on('keypress', this.handleMessageInput.bind(this))
    this.chatForm.on('submit', this.submitMessage.bind(this))
    this.channel.on("user:joined", this.addNewUser.bind(this))
    this.channel.on("message:new", this.addNewMessage.bind(this))
  }

  handleMessageInput(event) {
    if (event.keyCode === ENTER && !event.shiftKey) {
      this.chatForm.submit();
      return false;
    }
  }

  submitMessage() {
    let message = $.trim(this.chatInput.val())
    if (message.length) {
      this.channel.push("message:new", {body: message})
    }
    this.chatInput.val(EMPTY)
    return false;
  }

  addNewUser({user: user}) {
    this.usersList.append(`<p>${user.name}</p>`)
    this.messagesBoard.append(`<p><i>${user.name} has joined the room</i></p>`)
  }

  addNewMessage({user: user, body: body }) {
    this.messagesBoard.append(`
      <p>
        <i>${user.name} says:</i>
        <br/>
        ${body}
      </p>`
    )

    this.messagesBoard.scrollTop(this.messagesBoard.prop('scrollHeight'))
  }
}

export default ChatRoom
