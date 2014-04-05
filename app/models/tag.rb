class Tag < ActiveRecord::Base
	has_and_belongs_to_many :posts

	def self.create_tags(post, tags)
		tags.split.each do |tag|
			if Tag.exists?(name: tag)
				record = Tag.find_by(name: tag)
				post.tags << record
			else
				post.tags.create(name: tag)
			end
		end
	end
end
