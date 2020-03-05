class Personality < ApplicationRecord
  belongs_to :user
  belongs_to :attraction, optional: true
  has_many_attached :photos

  validates :name, presence: true
end
