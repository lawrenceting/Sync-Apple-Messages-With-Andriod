class Message < ApplicationRecord
  belongs_to :buddy, optional: true
end
