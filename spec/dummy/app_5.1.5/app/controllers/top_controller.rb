class TopController < ApplicationController
  include Calib::Controllers::BasicAuth

  basic_auth(user: 'myuser', password: 'secret')

  def index
  end
end  