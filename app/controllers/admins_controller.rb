class AdminsController < ApplicationController
  include Permissions
  before_action :check_privileges, only: [:manage]

  def manage
    @products = Product.order(created_at: :asc)
  end

end
