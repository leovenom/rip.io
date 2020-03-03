class Attraction < ApplicationRecord
  belongs_to :user
  has_many :personalities
  has_many :attractions_tours
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :description, presence: true
end
