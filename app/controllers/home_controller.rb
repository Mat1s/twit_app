class HomeController < ApplicationController
	def index
		@current_user = User.find(session[:current_user])	if session[:current_user]
	end
end
