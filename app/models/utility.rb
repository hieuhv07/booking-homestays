# frozen_string_literal: true

class Utility < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
