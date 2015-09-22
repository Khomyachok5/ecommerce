module Permissions
  extend ActiveSupport::Concern

  def check_privileges
    unless current_user.try(:is_admin)
      flash.alert = "This action is only available for administrators"
      redirect_to root_path
    end
  end
end