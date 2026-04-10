class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def authorize_admin
    redirect_to root_path unless user_signed_in? && current_user.admin?
  end
end
