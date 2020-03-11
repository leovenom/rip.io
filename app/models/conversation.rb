class Conversation < ApplicationRecord
  belongs_to :guide, class_name: "User", foreign_key: "guide_id"
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  has_many :messages, dependent: :destroy

  # If Sarah starts a conversation with Bradley, Sarah is the sender and Bradley the receiver. If Bradley wants to send Sarah a message, he should use the same conversation that has already been set up between those two users, even though he is now the sender
  validates_uniqueness_of :guide_id, scope: :user_id

  scope :between, -> (guide_id, user_id) do
    find_by("(conversations.guide_id = ? AND conversations.user_id = ?) OR (conversations.user_id = ? AND conversations.guide_id = ?)", guide_id, user_id, guide_id, user_id)
  end

  def recipient(current_user)
    self.guide_id == current_user.id ? self.user : self.guide
  end

  def unread_message_count(current_user)
    self.messages.where("user_id != ? AND read = ?", current_user.id, false).count
  end

end
