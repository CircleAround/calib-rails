module Calib::Devise::FriendlyForwardable
  extend ActiveSupport::Concern

  included do
    # @see https://github.com/plataformatec/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
    before_action :store_access_location!, if: :storable_location?
  end

  private

  # path with stored_location or root
  def smart_path(r = devise_key_for_store_location)
    stored_location_for(r) || root_path
  end

  def storable_location?
    request.get? &&
      is_navigational_format? &&
      !devise_controller? &&
      request.fullpath != root_path && # for return on creating new account
      !request.xhr?
  end

  def store_access_location!
    Rails.logger.debug("store_#{devise_key_for_store_location}_location!: #{request.fullpath}")
    store_location_for(devise_key_for_store_location, request.fullpath)
  end

  def devise_key_for_store_location
    Devise.mappings.keys[0]
  end
end