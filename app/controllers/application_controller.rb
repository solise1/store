class ApplicationController < ActionController::Base
  helper Turbo::FramesHelper if Rails.env.test?
  helper Turbo::StreamsHelper if Rails.env.test?

  include Locale

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern
  around_action :switch_locale

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.admin?
      admin_root_path
    else
      super
    end
  end

  private
    def authorize_admin
      redirect_to root_path unless user_signed_in? && current_user.admin?
    end
end
