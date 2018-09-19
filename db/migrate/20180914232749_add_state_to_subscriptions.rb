class AddStateToSubscriptions < ActiveRecord::Migration[5.1]
  def change
    add_column :subscriptions, :state, :string
  end
end
