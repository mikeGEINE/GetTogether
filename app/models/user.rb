class User < ApplicationRecord
  has_secure_password

  validates :mail, presence: true, uniqueness: true
  has_one_attached :avatar

  has_many :events, dependent: :destroy
  has_and_belongs_to_many :joined_events, class_name: 'Event'
end
