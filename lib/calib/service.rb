# @see https://techracho.bpsinc.jp/hachi8833/2017_10_16/46482
module Calib::Service
  extend ActiveSupport::Concern
  class_methods do
    def call(*args)
      new(*args).call
    end
  end
end
