require 'rails_helper'

RSpec.describe User, type: :model do
  before do
		auth = OmniAuth.config.mock_auth[:twitter]
		User.find_or_create_by_auth(auth)
	end

	it 'provider: twitter' do 
		expect(User.last.provider).to match("twitter")
	end

	it 'must have next secret' do 
		expect(User.last.secret).to match("neFkwZFUSuMQHXJ9CoDF2u02jxzIeQo6")
	end

	it 'must have next token' do 
		expect(User.last.token).to match("K4DwAgAAAAAA2_0aAAABX8Gdl85")
	end

	it "must have name: johndire" do 
		expect(User.last.name).to match("johndire")
	end

	it "must have image " do 
		expect(User.last.image).to be
	end
end

