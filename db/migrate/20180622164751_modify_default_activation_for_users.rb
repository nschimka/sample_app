class ModifyDefaultActivationForUsers < ActiveRecord::Migration[5.1]
  def change
  	change_column_default :users, :activated, from: true, to: false
  end
end