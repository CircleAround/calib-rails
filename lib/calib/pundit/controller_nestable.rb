# @see https://stackoverflow.com/questions/43707745/pundit-with-namespaced-controllers
module Calib::Pundit::ControllerNestable
  extend ActiveSupport::Concern

  included do
    class_attribute :namespace

    def self.nested_namespace(namespace)
      self.namespace = Array(namespace)
    end
  end

  def initialize(user, record)
    super
    @user = user
    @record = record.is_a?(Array) ? record.last : record
  end

  def scope
    Pundit.policy_scope! user, self.class.namespace + [record.class]
  end

  class Scope # :nodoc:
    attr_reader :user, :scope

    def initialize(user, scope)
      super
      @user = user
      @scope = scope.is_a?(Array) ? scope.last : scope
    end

    def resolve
      scope
    end
  end
end