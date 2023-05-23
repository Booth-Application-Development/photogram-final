class AddFollowToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :follow, :boolean
  end
end
