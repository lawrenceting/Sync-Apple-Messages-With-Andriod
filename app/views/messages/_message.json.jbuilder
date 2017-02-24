json.extract! message, :id, :content, :fullname, :buddyid, :buddy_id, :created_at, :updated_at
json.url message_url(message, format: :json)