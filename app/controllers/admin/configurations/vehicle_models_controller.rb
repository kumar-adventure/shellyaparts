class Admin::Configurations::VehicleModelsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_vehicle_model, only: [:show, :edit, :update, :destroy]
  layout 'configuration'	

  def edit
    @vehicle_makes = VehicleMake.all
  end

  def create
  	vehicle_model = VehicleModel.new vehicle_model_params.merge(published: true)
  	if vehicle_model.save
  	  flash[:notice] = "Vehicle Model '#{vehicle_model.name}' successfully created.."
  	else
  	  flash[:alert] = vehicle_model.errors.full_messages.join(",")
  	end
  	redirect_to admin_configurations_vehicle_makes_path
  end

  def update
    if @vehicle_model.update_attributes(vehicle_model_params)
      flash[:notice] = "Model updated successfully."
      redirect_to admin_configurations_vehicle_makes_path
    else
      flash[:alert] = @vehicle_model.errors.full_messages.join(",")
      render :edit
    end
  end

  def destroy
  	if @vehicle_model.destroy
      flash[:notice] = "Vehicle Model '#{@vehicle_model.name}' successfully deleted.."
  	else
  	  flash[:alert] = "Vehicle Model '#{@vehicle_model.name}' did not deleted successfully.."
  	end
  	redirect_to admin_configurations_vehicle_makes_path
  end

  private
  
  def vehicle_model_params
    params.require(:vehicle_model).permit(:name, :published, :vehicle_make_id)
  end

  def set_vehicle_model
  	@vehicle_model = VehicleModel.where(id: params[:id]).first
    redirect_to admin_configurations_vehicle_makes_path, alert: "Requested Vehicle Model does not exists.." if @vehicle_model.blank?  
  end
end
