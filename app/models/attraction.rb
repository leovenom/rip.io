class Attraction < ApplicationRecord
  belongs_to :user
  has_many :personalities
  has_many :attractions_tours
  has_many :tours, through: :attractions_tours

  geocoded_by :address
  has_many_attached :photos
  after_validation :geocode, if: :will_save_change_to_address?

  validates :photos, presence: true
  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :description, presence: true
end
