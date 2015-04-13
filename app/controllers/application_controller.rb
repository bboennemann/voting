class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  #layout 'my_account', if: :devise_controller?


  def after_sign_in_path_for(user)
    session[:redirect_path]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_in) << :ajax
  end


  def is_current_user? user_id
    if (user_signed_in? == false) or (user_id.to_s != current_user.id.to_s)
      flash[:warning_msg] = 'You do not have permission for this action.'
      redirect_to '/'
    end
  end

end
