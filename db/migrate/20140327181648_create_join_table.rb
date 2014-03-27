class CreateJoinTable < ActiveRecord::Migration
  def change
  	create_join_table :posts, :tags, table_name: :posts_tags
  end
end
