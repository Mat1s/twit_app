class Post < ApplicationRecord
	belongs_to :user

	def upload_image(img_params)
		FileUtils.mkdir_p(File.join(Rails.root, 'public', 'uploads', "#{self.id}"))
		File.open(Rails.root.join('public', 'uploads', "#{self.id}",
			img_params.original_filename), 'wb') do |file|
      file.write(img_params.read)
    end
    image = "/uploads/#{self.id}/#{img_params.original_filename}"
    update_columns(image: image)
	end

	def update_link(link_params)
		temp_link = link_params[/https:\/\/t.co\/\S*/] 
		update_columns(link_to_twitter: temp_link)
	end
end
