class Message < ApplicationRecord
  belongs_to :buddy, optional: true
  after_create_commit { MessageBroadcastJob.perform_later self }
end
