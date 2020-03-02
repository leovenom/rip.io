class Attraction < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :description, presence: true
end
