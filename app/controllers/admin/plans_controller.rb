class Admin::PlansController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  
  def index
  	@active_plans = Plan.active
  	@in_active_plans = Plan.inactive
  end

  def new
  	@plan = Plan.new
  end

  def create
  	@plan = Plan.new(plan_params)
  	if @plan.save
  	  redirect_to admin_plans_path, notice: "Plan successfully created."
  	else
  	  render :new 
  	end
  end

  def edit
  end

  def update
  	if @plan.update_attributes(plan_params)
  	  redirect_to admin_plans_path, notice: "Plan successfully Updated.."
  	else
      render :edit
  	end
  end

  def destroy
    if @plan.destroy
      flash[:notice] = "Plan has been deeted successfully.."
    end
    redirect_to admin_plans_path
  end

  private

  def plan_params
  	params.require(:plan).permit(:name, :price, :currency, :activated)
  end

  def set_plan
  	@plan = Plan.where(id: params[:id]).first
    redirect_to admin_plans_path, alert: "Requested plan does not exists.." if @plan.blank?
  end

end
