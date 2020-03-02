class Tour < ApplicationRecord
  belongs_to :guide, :class_name => 'User'

  validates :price, presence: true
end
