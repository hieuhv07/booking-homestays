# frozen_string_literal: true

class Price < ApplicationRecord
  has_many :bills, dependent: :destroy
  has_many :vouchers, through: :bills
  before_destroy :destroy_vouchers

  has_many :bills, dependent: :destroy
  has_many :vouchers, through: :bills
  belongs_to :room

  validates :cost,
            format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
            numericality: { greater_than: 0, less_than: 1_000_000 }

  scope :newest, -> { order created_at: :DESC }

  accepts_nested_attributes_for :vouchers, reject_if: :all_blank, allow_destroy: true

  def destroy_vouchers
    vouchers.each(&:destroy)
  end
end
