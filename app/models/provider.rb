class Provider < ApplicationRecord
    include Aliasable

    validates :alias, uniqueness: true
end
