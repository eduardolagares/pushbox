class System < ApplicationRecord
  has_many :devices
  include Labelable

  validates :label, uniqueness: true, presence: true
  validates :name, presence: true
end
