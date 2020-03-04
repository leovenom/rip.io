class Personality < ApplicationRecord
  belongs_to :attraction
  has_one_attached :photo

  validates :name, presence: true
end
