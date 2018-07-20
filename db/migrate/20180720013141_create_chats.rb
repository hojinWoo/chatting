class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.references :user, index: true, foreign_key: true
      t.references :chat_room, index: true, foreign_key: true
      t.text :message

      t.timestamps null: false
    end
  end
end
