class Admin::Configurations::VehicleMakesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_vehicle_make, only: [:show, :edit, :update, :destroy]
  layout 'configuration'	

  def index
    @vehicle_make  = VehicleMake.new
    @vehicle_model = VehicleModel.new
    @vehicle_makes = VehicleMake.all
    @vehicle_models = VehicleModel.all
  end

  def edit
  end

  def create
  	vehicle_make = VehicleMake.new vehicle_make_params.merge(published: true)
  	if vehicle_make.save
  	  flash[:notice] = "Vehicle Make '#{vehicle_make.name}' successfully created.."
  	else
  	  flash[:alert] = vehicle_make.errors.full_messages.join(",")
  	end
  	redirect_to admin_configurations_vehicle_makes_path
  end

  def update
    if @vehicle_make.update_attributes(vehicle_make_params)
      flash[:notice] = "Make updated successfully."
      redirect_to admin_configurations_vehicle_makes_path
    else
      flash[:alert] = @vehicle_make.errors.full_messages.join(",")
      render :edit
    end
  end

  def destroy
  	if @vehicle_make.destroy
      flash[:notice] = "Vehicle Makes '#{@vehicle_make.name}' successfully deleted.."
  	else
  	  flash[:alert] = "Vehicle Makes '#{@vehicle_make.name}' was not deleted successfully.."
  	end
  	redirect_to admin_configurations_vehicle_makes_path
  end

  private
  
  def vehicle_make_params
    params.require(:vehicle_make).permit(:name, :published)
  end

  def set_vehicle_make
  	@vehicle_make = VehicleMake.where(id: params[:id]).first
    redirect_to admin_configurations_vehicle_makes_path, alert: "Requested Vehicle Makes does not exists.." if @vehicle_make.blank?  
  end

end
