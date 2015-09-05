const ENTER = 13
const EMPTY = ""

class ChatRoom {
  constructor({roomId: roomId, socket: socket, user: user, context: context}) {
    this.roomId = roomId
    this.channel = socket.channel(`rooms:${roomId}`, { user: user })
    this.user = user
    this.chatInput  = context.find('[data-chat-input]')
    this.chatForm = context.find('[data-chat-form]')
    this.messagesBoard = context.find('[data-chat-messages]')
    this.usersList = context.find('[data-chat-users]')

    this.bindEvents()
  }

  connect() {
    this.channel.join()
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
      this.channel.push("message:new", { user: this.user, body: message })
    }
    this.chatInput.val(EMPTY)
    return false;
  }

  addNewUser({user: user}) {
    this.usersList.append(`<p>${user}</p>`)
    this.messagesBoard.append(`<p><i>${user} has joined the room</i></p>`)
  }

  addNewMessage({user: user, body: body }) {
    this.messagesBoard.append(`
      <p>
        <i>${user} says:</i>
        <br/>
        ${body}
      </p>`
    )

    this.messagesBoard.scrollTop(this.messagesBoard.prop('scrollHeight'))
  }
}

export default ChatRoom
