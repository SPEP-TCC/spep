class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!

  layout :layout_by_resource

  allow_browser versions: :modern
  include Pagy::Backend

  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end

end
