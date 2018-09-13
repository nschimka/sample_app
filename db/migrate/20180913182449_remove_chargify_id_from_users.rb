class RemoveChargifyIdFromUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :chargify_id
  end
end
