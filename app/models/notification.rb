class Notification < ApplicationRecord
  belongs_to :provider
  belongs_to :destiny, polymorphic: true

  enum body_type: { html: 1, text: 2 }

  validates_presence_of :body_type, :title
end
