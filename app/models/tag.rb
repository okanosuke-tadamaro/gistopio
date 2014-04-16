class Tag < ActiveRecord::Base
	has_and_belongs_to_many :posts
	validates :name, presence: true

	def self.create_tags(post, tags)
		if tags == ""
			tags = "none"
		end
		tags.split.each do |tag|
			if Tag.exists?(name: tag)
				record = Tag.find_by(name: tag)
				post.tags << record
			else
				post.tags.create(name: tag)
			end
		end
	end

	def self.update_tags(post, tags)
		post.tags.each { |post_tag| post.tags.delete(post_tag) if tags.include?(post_tag.name) == false }
		tags.split.each do |tag|
			if Tag.exists?(name: tag) && post.tags.exists?(name: tag) == false
				record = Tag.find_by(name: tag)
				post.tags << record
			elsif Tag.exists?(name: tag) == false
				post.tags.create(name: tag)
			end
		end
	end
end
