class User < ApplicationRecord
  has_many :tours, :class_name => 'Tour', :foreign_key => 'guide_id'
  has_many :attractions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
