require 'rails_helper'
RSpec.describe SessionsController, type: :controller do
	before do
		auth_hash = OmniAuth.config.mock_auth[:twitter]
	end

	describe "#create" do
		it 'succesfuly create user' do 
			expect(post :create, provider: :twitter).to change(User.count).by(1)
		end		

		it 'right message when create session' do
			post :create, provider: :twitter
			expect(flash[:success]).to be
		end

		it 'succesfuly create session' do
			post :create, provider: :twitter
			expect(:session[:current_user]).to eq(User.last.id)	
		end
	end
end
