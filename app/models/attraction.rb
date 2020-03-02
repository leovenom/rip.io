class Attraction < ApplicationRecord
  belongs_to :user
  has_many :personalities
  has_many :attractions_tours

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :description, presence: true
end
