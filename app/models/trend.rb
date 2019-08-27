class Trend < ApplicationRecord
  has_many :trend_rooms, dependent: :destroy
  has_many :rooms, through: :trend_rooms

  scope :newest, ->{order created_at: :desc}

  enum status: {active: 0, inactive: 1}
end
