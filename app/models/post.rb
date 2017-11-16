class Post < ApplicationRecord
	belongs_to :user
	validates :body, presence: true, length: 1..140
	paginates_per 10

	def create_twitt(twitt_user, id, body, *img)
		begin
			if img.length > 0 
				FileUtils.mkdir_p(File.join(Rails.root, 'public', 'uploads', 
					"#{id}")) # must edited
				File.open(Rails.root.join('public', 'uploads', "#{id}",
					img[0].original_filename), 'wb') do |file|
	     		file.write(img[0].read)
	    	end
	    	img_link = "/uploads/#{id}/#{img[0].original_filename}"
	    	twitt_user.update_with_media("#{body}", File.new("public/#{img_link}"))
	    else
	    	img_link = nil
	    	twitt_user.update("#{body}")
	    end
	    return img_link
	  rescue Twitter::Error::Unauthorized => e
    	if e
	    	flash[:info] = "Enter with twitter"
	    	redirect_to root_url
	    end
		end
	end

	def update_par(link, img)
		update_columns(link_to_twitter: link, image: img)
	end
end
