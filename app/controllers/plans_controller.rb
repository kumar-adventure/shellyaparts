class PlansController < ApplicationController
  before_action :authenticate_user!

  def index
  	@plans = Plan.all
  	@current_plan = current_user.subscriptions.active_plan.last
  	@addons = Addon.all
  	@current_addon = current_user.subscriptions.active_addon.last
  end
  
end
