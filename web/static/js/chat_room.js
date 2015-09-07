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
    let avatarMessage = this.gravatarURL(user.id, {s: 50})
    let avatarList = this.gravatarURL(user.id, {s: 25})

    this.usersList.append(`
      <div class="chat-user">
        <div class="chat-user-avatar">
          <img src="${avatarList}"/>
        </div>
        <p class="chat-user-body">${user.name}</p>
      </div>`
    )
    this.messagesBoard.append(`
      <div class="chat-message">
        <div class="chat-message-avatar">
          <img src="${avatarMessage}"/>
        </div>
        <p class='chat-message-body'>
          <i>${user.name} has joined the room</i>
        </p>
      </div>`
    )
  }

  addNewMessage({user: user, body: body }) {
    let avatar = this.gravatarURL(user.id, {s: 50})

    this.messagesBoard.append(`
      <div class="chat-message">
        <div class="chat-message-avatar">
          <img src="${avatar}"/>
        </div>
        <p class='chat-message-body'>
          <strong>${user.name}</strong>
          <br/>
          ${body}
        </p>
      </div>`
    )

    this.messagesBoard.scrollTop(this.messagesBoard.prop('scrollHeight'))
  }

  gravatarURL(email, options) {
    let hash = md5(email.toLowerCase())
    let params = $.param(options)
    return `//www.gravatar.com/avatar/${hash}?${params}`
  }
}

export default ChatRoom
