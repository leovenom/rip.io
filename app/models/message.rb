class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates_presence_of :content, :conversation, :user

  private

  def message_time
    created_at.strftime("%d/%m/%y at %l:%M %p")
  end
end
