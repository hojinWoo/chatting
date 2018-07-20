json.extract! chat_room, :id, :title, :master_id, :max_count, :admission_count, :created_at, :updated_at
json.url chat_room_url(chat_room, format: :json)
