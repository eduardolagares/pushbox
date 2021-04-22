class Tag < ApplicationRecord
    include Aliasable
    
    validates :alias, uniqueness: true
end
