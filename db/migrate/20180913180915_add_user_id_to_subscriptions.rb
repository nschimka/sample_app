class AddUserIdToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :user_id, :integer
  end
end
