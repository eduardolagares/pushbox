module Aliasable
    extend ActiveSupport::Concern
    included do
        scope :by_alias, ->(alias_name) { where(alias: alias_name) }
    end
end