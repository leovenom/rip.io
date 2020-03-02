class Personality < ApplicationRecord
  belongs_to :attraction

  validates :name, presence: true
end
