class Admin::Configurations::CategoryTypesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category_type, only: [:show, :edit, :update, :destroy]
  layout 'configuration'	

  def index
    @category_types = CategoryType.all
    @category_type = CategoryType.new
  end

  def edit
  end

  def create
  	@category_type = CategoryType.new category_type_params.merge(published: true)
  	if @category_type.save
  	  flash[:notice] = "Category Type '#{@category_type.name}' successfully created.."
  	else
  	  flash[:alert] = @category_type.errors.full_messages.join(",")
  	end
    redirect_to admin_configurations_category_types_path
  end

  def update
    if @category_type.update_attributes category_type_params
      flash[:notice] = "Category Type updated successfully."
      redirect_to admin_configurations_category_types_path
    else
      flash[:alert] = @category_type.errors.full_messages.join(",")
      render :edit
    end
  end

  def destroy
  	if @category_type.destroy
      flash[:notice] = "Category Type '#{@category_type.name}' successfully deleted.."
  	else
  	  flash[:alert] = "Category Type '#{@category_type.name}' was not deleted successfully.."
  	end
  	redirect_to admin_configurations_category_types_path
  end

  private
  
  def category_type_params
    params.require(:category_type).permit(:name, :published)
  end

  def set_category_type
  	@category_type = CategoryType.where(id: params[:id]).first
    redirect_to admin_configurations_category_types_path, alert: "Requested Category Type does not exists.." if @category_type.blank?  
  end


end
