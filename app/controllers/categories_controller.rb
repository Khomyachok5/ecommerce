class CategoriesController < ApplicationController
  include Permissions
  before_action :check_privileges, only: [:create, :new, :update, :edit, :destroy]
  
  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end


end
