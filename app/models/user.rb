class User < ApplicationRecord
	has_many :posts
	
	private
	def self.find_or_create_by_auth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.name = auth.info.nickname || auth.info.name
        user.uid = auth.uid
        user.provider = auth.provider
        user.image = auth.info.image
        user.token = auth.credentials.token
        user.secret = auth.credentials.secret
      end
    end
end
