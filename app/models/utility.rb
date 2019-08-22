class Utility < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :newest, ->{order created_at: :desc}
end
