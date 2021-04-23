class Tag < ApplicationRecord

    include Labelable

    validates :label, uniqueness: true, presence: true
    validates :name, presence: true
end
