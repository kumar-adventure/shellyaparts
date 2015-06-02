class Admin::AddonsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_addon, only: [:show, :edit, :update, :destroy]
  
  def index
  	@active_addons = Addon.active
  	@in_active_addons = Addon.inactive
  end

  def new
  	@addon = Addon.new
  end

  def create
  	@addon = Addon.new(addon_params)
  	if @addon.save
  	  redirect_to admin_addons_path, notice: "Addon successfully created."
  	else
  	  render :new 
  	end
  end


  def edit
  end

  def update
    if @addon.update_attributes(addon_params)
      redirect_to admin_addons_path, notice: "Addon successfully Updated.."
    else
      render :edit
    end
  end

  def destroy
  	addon = Addon.where(id: params[:id]).first
    if addon.destroy
      flash[:notice] = "Addon has been deeted successfully.."
    end
    redirect_to admin_addons_path
  end

  private

  def addon_params
  	params.require(:addon).permit(:name, :price, :currency, :activated)
  end

  def set_addon
    @addon = Addon.where(id: params[:id]).first
    redirect_to admin_addons_path, alert: "Requested Addon does not exists.." if @addon.blank?
  end

end
