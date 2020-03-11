class Tour < ApplicationRecord
  belongs_to :guide, class_name: 'User', foreign_key: 'user_id'

  has_many :bookings, dependent: :destroy
  has_many :attractions_tours, dependent: :destroy
  has_many :attractions, through: :attractions_tours
  has_many :reviews
  has_many_attached :photos
  has_many :orders, dependent: :destroy

  monetize :price_cents

  validates :price, presence: true
end
