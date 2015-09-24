class ProductsController < ApplicationController
  include Permissions
  before_action :check_privileges, only: [:create, :new, :update, :edit, :destroy]
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  
  def index
    @products = Product.search do
      if params[:search_no_subcats] #searches products disregarding subcategories
        with(:category_id, params[:search_no_subcats])        
      elsif !params[:category_search].blank? #search products accounting for subcategories
        cat_arr = []
        with(:category_id, find_subcategories(params[:category_search], cat_arr))
      end
      fulltext  params[:query]
      paginate :page => params[:page], :per_page => 12
    end.results
    #@total_pages = @products.total_pages    
    #@product_listing = Product.order(created_at: :asc)
    @categories = Category.order("title asc")
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      if params[:product][:pictures]
        @product.pictures.create(image: params[:product][:pictures][:image])
      end
      redirect_to product_path(@product)
    else
      flash.alert = @product.errors.full_messages.join('. ')
      redirect_to new_product_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      flash.notice = "Product successfully modified"
      redirect_to product_path(@product)
    else
      flash.alert = @product.errors.full_messages.join('. ')
      redirect_to new_product_path
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, :stock, :slug, :category_id, :pictures, pictures_attributes: [:id, :product_id, :image])
  end

  def find_product
    @product = Product.friendly.find(params[:id])
  end

  def find_subcategories(parent_cat, cat_arr)
    Category.find(parent_cat).subcategories.each do |s|
      cat_arr << s.id 
    end
    cat_arr << parent_cat
    cat_arr
  end

end
