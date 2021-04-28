class Provider < ApplicationRecord
  has_many :devices
  has_many :notifications

  include Labelable

  validates :label, uniqueness: true, presence: true
  validates :name, presence: true
  validates :delivery_class_name, presence: true
end
