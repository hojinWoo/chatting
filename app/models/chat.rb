class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_room

  after_commit :chat_message_notification, on: :create

  def chat_message_notification
    # 채팅방 이름 , event, 데이터
    Pusher.trigger("chat_room_#{self.chat_room_id}", 'chat', self.as_json.merge({email: self.user.email}))
  end
end
