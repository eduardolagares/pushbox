class Device < ApplicationRecord
  include ApiKeyGenerator
  belongs_to :provider
  belongs_to :system
  has_many :subscriptions
  has_many :notifications, as: :destiny

  scope :by_system_label, ->(label) { joins(:system).where(systems: { label: label }) unless label.blank? }
  scope :by_provider_label, ->(label) { joins(:provider).where(providers: { label: label }) unless label.blank? }
  scope :by_external_identifier, lambda { |external_identifier|
                                   where(external_identifier: external_identifier) unless external_identifier.blank?
                                 }
  scope :by_tag, ->(tag) { where("? IN (tags)", tag) unless tag.blank? }

  validates :provider_identifier, uniqueness: { scope: %i[provider_id system_id] }, presence: true

  before_create :generate_api_key

  # Fix pundits problems
  def admin?
    false
  end

  def client?
    true
  end
end
