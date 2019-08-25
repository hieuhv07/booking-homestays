# frozen_string_literal: true

class FavoriteSpace < ApplicationRecord
  scope :newest, ->{order created_at: :desc}

  validates :name, length: { in: 3..50 }, uniqueness: { case_sensitive: false }
end
