class AddUidParentToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :uid_parent, :string
  end
end
