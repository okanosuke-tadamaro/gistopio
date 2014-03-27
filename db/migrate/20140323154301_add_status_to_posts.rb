class AddStatusToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sync_status, :boolean, default: false
    add_column :posts, :public_status, :boolean, default: false
  end
end
