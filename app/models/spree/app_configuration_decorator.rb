# frozen_string_literal: true

module Spree::AppConfigurationDecorator
  def self.prepended(base)
    base.preference :taxjar_api_key, :string
    base.preference :taxjar_enabled, :boolean, default: false
    base.preference :taxjar_debug_enabled, :boolean, default: false
  end
end

::Spree::AppConfiguration.prepend(Spree::AppConfigurationDecorator)
