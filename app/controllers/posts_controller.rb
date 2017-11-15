class PostsController < ApplicationController
  before_action :check_session 
  
  def index
  	@posts = Post.order('id DESC')
  	@post = Post.new
  end

  def create
  	@post = @current_user.posts.new(permit_params)
    if params[:post][:image]
      if !params[:post][:image].content_type.match(/^image\S*/i)
        #!params[:post][:image].original_filename.match(/\S*.(jpg|jpeg|gif|bmp|tiff|png)$/i)
        flash[:warning] = "You must choose only image"
        params[:post][:image] = nil
        redirect_to root_url
      elsif params[:post][:image].size > 5242879
        flash[:warning] = "Size of upload picture is very large"
        redirect_to root_url
      else 
        image = @post.create_twitt(get_client, params[:user_id], 
          params[:post][:body], params[:post][:image])
        @post.save
        homeline = get_client.home_timeline(count: 1).first.text
        link = homeline[/https:\/\/t.co\/\S*/]
        @post.update_par(link, image)
        flash[:success] = "Create twit with image"
        redirect_to posts_path
      end
    else
      image = @post.create_twitt(get_client, params[:user_id], 
          params[:post][:body])
      @post.save
      homeline = get_client.home_timeline(count: 1).first.text
      link = homeline[/https:\/\/t.co\/\S*/]
      @post.update_par(link, image)
       flash[:success] = "Create twit without image"
      redirect_to posts_path
    end
  end
    
  protected

  def check_session
  	redirect_to root_url if !session[:current_user]
   	@current_user = User.find(session[:current_user])
    rescue ActiveRecord::RecordNotFound => e
    if e
      flash[:warning] = "Please, log in"
    end
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
