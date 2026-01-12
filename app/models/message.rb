class Message < ApplicationRecord
  acts_as_message tool_calls_foreign_key: :message_id
  has_many_attached :attachments

  after_create_commit :broadcast_to_user

  private

  def broadcast_to_user
    return if role == "system"
    broadcast_append_to [ chat.user, :chat ], target: "messages_container"
  end
end
