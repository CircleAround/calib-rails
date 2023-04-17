# == Soft deletation for devise
# use with SoftDeletionMigrationEnhancable
#
# === usage 
# include to Devise Model.
#
#  class User < ApplicationRecord
#    include Calib::Devise::SoftDeletion
#
#    devise :database_authenticatable, :registerable,
#           :recoverable, :rememberable, :trackable, :validatable,
#           :confirmable  
#
#    devise_soft_deletable # call below `device` method 
#
#    ...
#  end  
module Calib::Devise::SoftDeletion
  extend ActiveSupport::Concern

  included do
    class_attribute :alive_column_name

    # initialize method to call on Devise Model.
    def self.devise_soft_deletable(alive_column_name = :alive)
      self.alive_column_name = alive_column_name

      # @see http://blog.319ring.net/2016/05/24/devise-kakurenbo-puti/
      # remove unique email Devise::validatable
      # https://gist.github.com/brenes/4503386
      self._validators.delete(:email)
      self._validate_callbacks.each do |callback|
        if callback.filter.respond_to? :attributes
          callback.filter.attributes.delete :email
        end
      end

      # redefine email unique with column for soft deletation
      self.validates :email, presence: true
      self.validates_format_of :email, with: email_regexp, allow_blank: true, if: :will_save_change_to_email?
      self.validates :email, uniqueness: { scope: alive_column_name }, if: :will_save_change_to_email?

      self.scope :alive, -> { where(alive_column_name => 1) }
    end

    def self.find_for_authentication(warden_conditions)
      alive.where(email: warden_conditions[:email]).first
    end
  end

  # check canceled
  def canceled?
    self.alive_value == nil
  end

  # do soft destroy
  def soft_destroy
    save if pre_destroy
  end

  # do soft destroy! 
  def soft_destroy!
    save! if pre_destroy
  end

  # get alive_column_value
  def alive_value
    self.send(self.class.alive_column_name)
  end

  private

  def pre_destroy
    return false if canceled?

    self.attributes = cancel_attributes
    self.skip_reconfirmation!
    true
  end

  def cancel_attributes
    key = Devise.friendly_token.first(8)

    attrs = {
      email: "calceled_#{self.id}_#{key}@canceled.com",
      password: key,
      canceled_at: Time.zone.now
    }

    attrs[self.class.alive_column_name] = nil
    attrs
  end
end