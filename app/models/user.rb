class User < ApplicationRecord
  has_many :guided_tours, :class_name => 'Tour', source: 'User'

  has_many :bookings
  has_many :tours, through: :bookings
  has_many :attractions
  has_many :personalities
  has_many :reviews
  has_many :orders

  has_one_attached :profile_picture

  enum role: [:user, :guide, :admin]

  after_initialize do
  if self.new_record?
    self.role ||= :user
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
