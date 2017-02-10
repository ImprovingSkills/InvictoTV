class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :authenticate_user!, exept: :index, :create, :new
  def index
  	@user = User.new
    @user.build_profile
  end
end
