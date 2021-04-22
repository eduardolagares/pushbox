class System < ApplicationRecord
    include Aliasable

    validates :alias, uniqueness: true
end
