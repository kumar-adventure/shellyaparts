class Admin::Configurations::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  layout 'configuration'	

  def index
    @categories = Category.all
  end

  def new
  	@category = Category.new
  	@category_types = CategoryType.all
  end

  def edit
  	@category_types = CategoryType.all
  end

  def create
  	@category = Category.new category_params.merge(published: true)
  	if @category.save
  	  flash[:notice] = "Category '#{@category.name}' successfully created.."
  	  redirect_to admin_configurations_categories_path
  	else
  		@category_types = CategoryType.all
  	  flash[:alert] = @category.errors.full_messages.join("<br/>")
  	  render :new
  	end
  end

  def update
    if @category.update_attributes category_params
      flash[:notice] = "Category updated successfully."
      redirect_to admin_configurations_categories_path
    else
      flash[:alert] = @category.errors.full_messages.join(",")
      render :edit
    end
  end

  def destroy
  	if @category.destroy
      flash[:notice] = "Category '#{@category.name}' successfully deleted.."
  	else
  	  flash[:alert] = "Category '#{@category.name}' was not deleted successfully.."
  	end
  	redirect_to admin_configurations_categories_path
  end

  private
  
  def category_params
    params.require(:category).permit(:name, :published, :category_alias, :category_type_id, :avatar, :description)
  end

  def set_category
  	@category = Category.where(id: params[:id]).first
    redirect_to admin_configurations_categories_path, alert: "Requested Category does not exists.." if @category.blank?  
  end

end
