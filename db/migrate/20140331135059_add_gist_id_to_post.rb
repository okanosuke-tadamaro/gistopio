class AddGistIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :gist_id, :string, default: ""
  end
end
