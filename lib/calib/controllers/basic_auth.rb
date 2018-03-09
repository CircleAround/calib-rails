# == A Module for Basic Authentication 
# authenticated status stored in session.
# avoid frequently logging in
#
# === usage
#  class ApplicationController < ActionController::Base
#    include Calib::Controllers::BasicAuth
#    basic_auth(user: 'myuser', pass: 'secret')
#    ...
#  end
# 
# === options
#  basic_auth # read ENV['BASIC_AUTH_USER'] and ENV['BASIC_AUTH_PASS']
#  basic_auth(user: 'myuser', pass: 'secret') # standard
#
#  basic_auth(user: 'myuser', pass: 'secret') do |request|
#    request.domain != 'localhost' # localhost is unblocked domain.
#  end
module Calib::Controllers::BasicAuth
  extend ActiveSupport::Concern

  included do
    class_attribute :basic_auth_user, :basic_auth_pass, :basic_auth_session_key, :basic_auth_block

    def self.basic_auth(user: ENV['BASIC_AUTH_USER'], password: ENV['BASIC_AUTH_PASS'], key: :basic_auth, &block)
      self.basic_auth_user = user
      self.basic_auth_pass = password
      self.basic_auth_session_key = key
      self.basic_auth_block = block
    end

    before_action -> {
                    return if self.class.basic_auth_user.blank?
                    return if session[self.class.basic_auth_session_key].present?
                    return if self.class.basic_auth_block.present? && !self.class.basic_auth_block.call(request)

                    authenticate_or_request_with_http_basic do |user, pass|
                      if user == self.class.basic_auth_user && pass == self.class.basic_auth_pass
                        session[self.class.basic_auth_session_key] = true
                        return true
                      end
                      false
                    end
                  }
  end
end
