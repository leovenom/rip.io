class Order < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  monetize :amount_cents
end
