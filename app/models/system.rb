class System < ApplicationRecord
  include Labelable

  has_many :devices

  validates :label, uniqueness: true, presence: true
  validates :name, presence: true
end
