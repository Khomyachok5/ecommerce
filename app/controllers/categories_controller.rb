class CategoriesController < ApplicationController
  include Permissions
  before_action :check_privileges, only: [:create, :new, :update, :edit, :destroy]
  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash.notice = "A new category has been successfully created"
      redirect_to admin_path
    else
      flash.alert = @category.errors.full_messages.join('. ')
      render :new
    end
  end

  def show
    @products = Product.where(category: @category)
  end

  def update
    if check_dependencies(@category, params[:category][:parent_category_id])
      if @category.update_attributes(category_params)
        flash.notice = "The category has been updated"
        redirect_to admin_path
      else
        flash.error = @category.errors.full_messages.join('. ')
        render :edit
      end
    else
      redirect_to edit_category_path(@category)
    end
  end

  def edit
  end

  def destroy
    if !@category.subcategories.any? && !@category.products.any?
      @category.destroy
      flash.notice = "The category has been successfully removed"
      redirect_to admin_path
    else
      flash.alert = "The category cannot be deleted as it has dependent products or subcategories. Please, move dependent entities to other categories first using Edit action."
      redirect_to admin_path
    end
  end

  def bulk_update
    current_category = Category.find(params[:current_category].to_i)
    if current_category.update_products(params[:category_new].to_i)
      flash.notice = "Products have been sucessfully moved to another category"
    else
      flash.alert = @category.errors.full_messages.join('. ')
    end
    redirect_to admin_path
  end

  private

  def category_params
    params.require(:category).permit(:title, :parent_category_id)
  end

  def find_category
    @category = Category.friendly.find(params[:id])
  end

  def check_dependencies(previous_cat, new_cat)
    if previous_cat.subcategories.any? || previous_cat == new_cat
      flash.alert = "Category cannot be updated to use the selected entity as its parent. Category must not be a parent to itself. Any dependent subcategory (immediate or indirect relation) cannot act as a parent to a higher level predecessor to avoid an infinite loop. Please, move all child categories from this category before proceeding. Update is not available for categories with subcategories in place."
      false
    else
      true
    end
  end

end
