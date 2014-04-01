class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, :foreign_key => "author_id"
  validates :body, presence: true
end
