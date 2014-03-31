class AddGistUrlToPost < ActiveRecord::Migration
  def change
    add_column :posts, :gist_url, :string, default: ""
  end
end
