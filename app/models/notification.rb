class Notification < ApplicationRecord
  belongs_to :provider
  belongs_to :destiny

  enum body_type: {html: 1, text: 2}
end
