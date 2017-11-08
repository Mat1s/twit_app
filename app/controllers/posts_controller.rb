class PostsController < ApplicationController
  before_action :check_entity 
  def index
  	@posts = Post.order('id DESC')
  	@post = Post.new
  	@home_timeline = get_client.home_timeline(count: 10)
  end

  def create
  	@post = @current_user.posts.new(permit_params)
  	if @post.save
  		@post.upload_image(params[:post][:image]) if params[:post][:image]
	  		if @post.image
	  			get_client.update_with_media("#{@post.body}", File.new("public/#{@post.image}"))
	  		else
	  			get_client.update("#{@post.body}")
	  		end
			link = get_client.home_timeline(count: 1).first.text
      @post.update_link(link)
  		flash.now[:success] = "Twit successfully created"
  		redirect_to posts_path	
  	else
  		redirect_to root_url
  		flash[:notice] = "Not valid params"
  	end
  end

  private

  def check_entity
  	redirect_to root_url if !session[:current_user]
   	@current_user = User.find(session[:current_user])
  end

  def permit_params
 	  params.require(:post).permit(:user_id, :image, :body)
  end

  def get_client
		Twitter::REST::Client.new do |config|
		  config.consumer_key = OAUTH_CREDENTIALS[:twitter][:api_id]
		  config.consumer_secret = OAUTH_CREDENTIALS[:twitter][:api_secret]
		  config.access_token = User.find(@current_user.id).token
		  config.access_token_secret = User.find(@current_user.id).secret
		end
	end
end
