module Calib::Devise::FriendlyForwardable
  extend ActiveSupport::Concern

  included do
    # @see https://github.com/plataformatec/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
    before_action :store_location!, if: :storable_location?
  end

  private

  def after_sign_in_path_for(resource)
    friendly_forwarding_path(resource)
  end

  # path with stored_location or root
  # @see https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
  def friendly_forwarding_path(r = devise_key_for_store_location)
    request.env['omniauth.origin'] || stored_location_for(r) || signed_in_root_path(r)
  end

  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      request.fullpath != signed_in_root_path(devise_key_for_store_location) && # for return on creating new account
      !request.xhr?
  end

  def store_location!
    Rails.logger.debug("store_#{devise_key_for_store_location}_location!: #{request.fullpath}")
    store_location_for(devise_key_for_store_location, request.fullpath)
  end

  def devise_key_for_store_location
    Devise.mappings.keys[0]
  end
end