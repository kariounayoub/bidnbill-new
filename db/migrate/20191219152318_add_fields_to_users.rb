class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_admin, :boolean, default: false
    add_column :accounts, :number_users_allowed, :integer, default: 1
  end
end
