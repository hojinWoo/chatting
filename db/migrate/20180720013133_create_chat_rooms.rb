class CreateChatRooms < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|
      t.string :title
      t.string :master_id
      t.integer :max_count
      t.integer :admissions_count, default: 0

      t.timestamps null: false
    end
  end
end
