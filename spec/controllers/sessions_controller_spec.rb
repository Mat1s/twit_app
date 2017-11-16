require 'rails_helper'
RSpec.describe SessionsController, type: :controller do
	before do
		request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
	end

	describe "#create" do
		it 'succesfuly create user' do 
			post :create, provider: :twitter
			expect(User.find_by(uid: "23412")).to be
		end		

		
		it 'succesfuly create session' do
			post :create, provider: :twitter
			expect(session[:current_user]).to eql(User.last.id)	
		end

		it 'show message that user created' do
			post :create, provider: :twitter
			expect(flash[:success]).to match("User successfully authenticate")		
		end

		it 'create new session' do 
			expect(session[:current_user]).to be_nil
			post :create, provider: :twitter
			expect(session[:current_user]).to eql(User.last.id)
		end
	end

	describe "#destroy" do
	  before do
	  	post :create, provider: :twitter
	  end
	  	
	  it 'session must be null after log out' do
	   	expect(session[:current_user]).to_not be_nil
	   	delete :destroy
	   	expect(session[:current_user]).to be_nil 
	  end
		
		it 'after destroy session redirect to root_url' do
			delete :destroy
			expect(subject).to redirect_to root_url
		end

		it 'message after redirect' do 
			delete :destroy
			expect(flash[:warning]).to match("User closed your session")
		end
	end
end
