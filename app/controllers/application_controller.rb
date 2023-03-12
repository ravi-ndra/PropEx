class ApplicationController < ActionController::Base
  include ActionController::Helpers
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role])
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def authenticate_admin_user!
    raise SecurityError unless current_user.try(:admin?)
  end

  rescue_from SecurityError do |exception|
    p "You are not Admin!"
    redirect_to root_url
  end

  private
  def after_sign_out_path_for(resource_or_scope)
    root_path  
  end

  def after_sign_in_path_for(resource_or_scope)
    root_path
  end
end
