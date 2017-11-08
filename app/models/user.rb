class User < ApplicationRecord
	has_many :posts
	
	private
	def self.find_or_create_by_auth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.update(name: auth.info.name, uid: auth.uid,
        provider: auth.provider, image: auth.info.image,
        token: auth.credentials.token, secret: auth.credentials.secret)
      end
    end
end
