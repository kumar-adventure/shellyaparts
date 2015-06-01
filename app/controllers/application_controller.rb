class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected

  def check_subscription
  	if current_user
  	  if current_user.subscriptions.blank? || !current_user.subscriptions.last.is_active
  	  	redirect_to plans_path, alert: "Please choose a plan Firstly  !!!!"
  	  end
  	end
  end

end
