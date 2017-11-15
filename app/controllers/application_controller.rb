class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	# rescue_from ActiveRecord::RecordInvalid, :with => :render_500
	# rescue_from ActionController::MissingFile, :with => :render_404
	# rescue_from ActionController::RoutingError, with: :render_404
	# rescue_from ActionView::TemplateError, :with => :render_500
  # rescue_from Errno::ENOENT, :with => :render_404
  # rescue_from Errno::EACCES, :with => :render_404

  # def render_404
  # 	redirect_to root_url
  # end
end

