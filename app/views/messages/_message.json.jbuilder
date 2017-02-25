json.extract! message, :id, :content, :fullname, :buddyid, :sent, :received, :delivered, :buddy_id, :created_at, :updated_at
json.url message_url(message, format: :json)