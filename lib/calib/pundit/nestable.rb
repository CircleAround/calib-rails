# @see https://stackoverflow.com/questions/43707745/pundit-with-namespaced-controllers
# @see https://github.com/elabs/pundit/pull/392/files
module Calib::Pundit::Nestable
  extend ActiveSupport::Concern

  included do
    class_attribute :namespace

    def self.nested_namespace(namespace)
      self.namespace = Array(namespace)
    end
  end

  def policy_scope(scope)
    super self.class.namespace + [scope]
  end

  def authorize(record, query = nil)
    super self.class.namespace + [record], query
    record
  end

  def policy(record)
    # if record is Array, as already namespace array
    super record.is_a?(Array) ? record : self.class.namespace + [record]
  end
end