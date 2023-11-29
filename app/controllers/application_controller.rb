class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :is_anya

  def current_user
    # If session[:user_id] is nil, set it to nil, otherwise find the user by id.
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def is_anya
    if current_user && current_user.name == 'anya'
      @is_anya = true
    end
  end

  def not_found_method
    render :file => "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end