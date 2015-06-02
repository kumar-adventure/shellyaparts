class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }


  def routing_error
    render :file => 'public/404.html', :status => :not_found
  end

  protected

  def check_subscription
  	if current_user
  	  if current_user.subscriptions.blank? || !current_user.subscriptions.last.is_active
  	  	redirect_to plans_path, alert: "Please choose a plan Firstly  !!!!"
  	  end
  	end
  end

  def render_error(status, exception)
    Rails.logger.error status.to_s + " " + exception.message.to_s
    Rails.logger.error exception.backtrace.join("\n") 
    respond_to do |format|
      format.html { render :file => 'public/404.html', status: status }
      format.all { render nothing: true, status: status }
    end
  end

end
