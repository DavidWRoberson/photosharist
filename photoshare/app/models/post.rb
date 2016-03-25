class Post < ActiveRecord::Base
	validates :image, presence: true

	has_attached_file :image, styles: { :medium => "640x" }
	valildates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
