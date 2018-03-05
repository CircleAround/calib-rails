module Calib::Delegatable
  extend ActiveSupport::Concern

  included do
    def self.delegate_all(targets)
      targets = Array(targets)
      define_method('method_missing') do |method, *args|
        target = targets.find {|target| target.respond_to?(method) }
        return target.send(method, *args) if target.present?
        super
      end
    end
  end
end