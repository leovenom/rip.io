class Tour < ApplicationRecord
  belongs_to :guide, :class_name => 'User', foreign_key: 'user_id'

  has_many :attractions_tours
  has_many :attractions, through: :attractions_tours
  has_many :reviews

  validates :price, presence: true
end
