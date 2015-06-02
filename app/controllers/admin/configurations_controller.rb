class Admin::ConfigurationsController < ApplicationController
  before_action :authenticate_admin!
  layout 'configuration'
  
  def index
  end

end
