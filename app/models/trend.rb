class Trend < ApplicationRecord
  has_many :trend_rooms, dependent: :destroy
  has_many :rooms, through: :trend_room, foreign_key: :trend_id

  scope :newest, ->{order created_at: :desc}
end
