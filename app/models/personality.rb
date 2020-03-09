class Personality < ApplicationRecord
  belongs_to :user
  belongs_to :attraction, optional: true
  geocoded_by :address
  has_many_attached :photos
  after_validation :geocode, if: :will_save_change_to_address?


   validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :description, presence: true
end
