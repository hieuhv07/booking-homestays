# frozen_string_literal: true

class Room < ApplicationRecord
  attr_writer :current_step
  attr_accessor :step1, :step2, :confirmation

  has_many :room_utilities, dependent: :destroy
  has_many :utilities, through: :room_utilities
  has_many :trend_rooms, dependent: :destroy
  has_many :room_images, dependent: :destroy
  has_many :trends, through: :trend_rooms
  has_one :price, dependent: :destroy
  belongs_to :user
  belongs_to :location
  belongs_to :favorite_space

  validates :name, presence: true
  validates :address, presence: true
  validates :guest, presence: true, numericality: { only_integer: true }
  validates :bed_room, presence: true, numericality: { only_integer: true }
  validates :bath_room, presence: true, numericality: { only_integer: true }
  validates :type_room, presence: true

  scope :newest, ->{order created_at: :desc}

  validates :address, presence: true, length: { maximum: 50 },
                      if: ->(o) { o.current_step == "step2" }

  validates :name, presence: true, length: { maximum: 50 },
                   if: ->(o) { o.current_step == "step1" }

  validates :guest, presence: true, numericality: { only_integer: true },
                    if: ->(o) { o.current_step == "step1" }

  validates :bed_room, presence: true, numericality: { only_integer: true },
                       if: ->(o) { o.current_step == "step1" }

  validates :bath_room, presence: true, numericality: { only_integer: true },
                        if: ->(o) { o.current_step == "step1" }

  validates :type_room, presence: true, if: ->(o) { o.current_step == "step1" }

  enum type_room: { private_room: 0, entire: 1 }

  accepts_nested_attributes_for :room_images, allow_destroy: true

  delegate :name, to: :location, prefix: true

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[step1 step2 confirmation]
  end

  def next_step
    self.current_step = steps[steps.index(current_step) + 1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step) - 1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
