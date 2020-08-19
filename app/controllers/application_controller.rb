class ApplicationController < ActionController::Base
  helper_method :current_user # it will make it available everywhere

  def current_user
    return @current_user if @current_user.present?

    if session[:user_id].present?
      @current_user = User.find(session[:user_id])
    else
      @current_user = User.generate
      session[:user_id] = @current_user.id
      @current_user
    end
  end
end
