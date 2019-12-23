class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"

  has_and_belongs_to_many :attendances, class_name: "User", optional: true

  belongs_to :event_type

  has_one_attached :image
  validates :date, presence: true
  validates :name, presence: true
  validates :address, presence: true
end
