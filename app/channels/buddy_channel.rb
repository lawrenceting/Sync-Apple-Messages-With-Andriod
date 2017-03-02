class BuddyChannel < ApplicationCable::Channel
  def subscribed
    stream_from "buddy_#{params['buddy_id']}"
  end
 
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
 
  def speak(data)
    # ActionCable.server.broadcast "buddy_channel", message: data['message']
    Message.create! content: data['message'], buddy_id: data['buddy_id'], buddyid: data['buddyid'], sent: true, delivered: false
  end
end