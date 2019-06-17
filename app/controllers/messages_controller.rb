class MessagesController < ApplicationController
  def index
    @chat_messages = [
      { username: 'test-user', date: '2019/06/08(Sun) 00:00:00', message: 'こんにちは！'},
      { username: 'test-user2', date: '2019/06/08(Sun) 01:00:00', message: 'さようなら！'}
    ]
  end
end
