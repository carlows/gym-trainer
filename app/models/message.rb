class Message < ApplicationRecord
  acts_as_message tool_calls_foreign_key: :message_id
  has_many_attached :attachments

  after_create_commit :broadcast_to_user

  def entities
    return [] unless content_raw.is_a?(Hash) && content_raw["metadata"].present?

    metadata = content_raw["metadata"]
    case metadata["type"]
    when "routine_list", "routine_created"
      Routine.where(id: metadata["ids"]).includes(routine_days: :routine_exercises)
    when "exercise_list"
      Exercise.where(id: metadata["ids"])
    else
      []
    end
  end

  private

  def broadcast_to_user
    return if role == "system"

    # Broadcast JSON for VueJS instead of Turbo Streams
    ActionCable.server.broadcast(
      "chat_#{chat.user.id}",
      {
        id: id,
        role: role,
        content: content,
        content_raw: content_raw,
        created_at: created_at,
        metadata: content_raw.is_a?(Hash) ? content_raw["metadata"] : nil
      }
    )
  end
end
