module Labelable
  extend ActiveSupport::Concern

  included do
    scope :by_label, ->(label) { where(label: label) }
  end
end
