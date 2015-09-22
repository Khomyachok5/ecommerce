class CategoriesController < ApplicationController
  include Permissions
  before_action :check_privileges, only: [:create, :new, :update, :edit, :destroy]
  before_action :find_category, only: [:edit, :update, :destroy]
  
  def new
  end

  def create
    @category = Category.new(category_params)
      if @category.save
        flash.notice = "A new category has been successfully created"
        redirect_to admin_path
      else
        flash.alert = @category.errors.full_messages.join('. ')
        redirect_to admin_path
      end
  end

  def update
    @category.update_attributes(category_params)
    flash.notice = "The category has been updated"
    redirect_to admin_path  
  end

  def edit
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:title, :parent_category_id)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
