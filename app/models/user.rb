class User < ApplicationRecord
  has_many :tours, :class_name => 'Tour', :foreign_key => 'guide_id'
  has_many :attractions

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
