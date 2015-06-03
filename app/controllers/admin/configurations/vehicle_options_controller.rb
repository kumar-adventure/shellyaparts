class Admin::Configurations::VehicleOptionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_vehicle_option, only: [:edit, :update, :destroy]
  layout 'configuration'	

  def index
    @vehicle_options = VehicleOption.all
    @vehicle_option  = VehicleOption.new
  end

  def edit
  end

  def create
  	@vehicle_option = VehicleOption.new vehicle_option_params.merge(published: true)
  	if @vehicle_option.save
  	  flash[:notice] = "Vehicle Option '#{@vehicle_option.name}' successfully created.."
  	else
  	  flash[:alert] = @vehicle_option.errors.full_messages.join(",")
  	end
    redirect_to admin_configurations_vehicle_options_path
  end

  def update
    if @vehicle_option.update_attributes vehicle_option_params
      flash[:notice] = "Vehicle Option updated successfully."
      redirect_to admin_configurations_vehicle_options_path
    else
      flash[:alert] = @vehicle_option.errors.full_messages.join(",")
      render :edit
    end
  end

  def destroy
  	if @vehicle_option.destroy
      flash[:notice] = "Vehicle Option '#{@vehicle_option.name}' successfully deleted.."
  	else
  	  flash[:alert] = "Vehicle Option '#{@vehicle_option.name}' was not deleted successfully.."
  	end
  	redirect_to admin_configurations_vehicle_options_path
  end

  private
  
  def vehicle_option_params
    params.require(:vehicle_option).permit(:name, :published)
  end

  def set_vehicle_option
  	@vehicle_option = VehicleOption.where(id: params[:id]).first
    redirect_to admin_configurations_vehicle_options_path, alert: "Requested Vehicle Option does not exists.." if @vehicle_option.blank?  
  end

end
