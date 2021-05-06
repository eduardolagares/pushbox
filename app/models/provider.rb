class Provider < ApplicationRecord
  include Labelable
  
  has_many :devices
  has_many :notifications

  validates :label, uniqueness: true, presence: true
  validates :name, presence: true
  validates :delivery_class_name, presence: true
  validate :validate_delivery_class

  def max_devices_per_request
    delivery_class.max_devices_per_request
  end

  def is_topic_suported
    delivery_class.is_topic_suported
  end
  
  def delivery_class
    Object.const_get(delivery_class_name)
  end

  private

  def validate_delivery_class
    return if delivery_class.ancestors.include?(Pushbox::Delivery::Expo)
    errors.add :delivery_class_name, "The delivery class must inherit Pushbox::Delivery::Base."
  end
end
