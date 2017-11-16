require 'rails_helper'
RSpec.describe PostsController, type: :controller do
	describe "GET #index" do
      it "renders the index template" do
      get :index
      expect(response).to redirect_to root_url
    end
  end
end
