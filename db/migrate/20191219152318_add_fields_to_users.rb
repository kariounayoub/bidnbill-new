class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_admin, :boolean, default: false
    add_column :users, :is_active, :boolean, default: true
    add_column :users, :picture, :string
    add_column :accounts, :number_users_allowed, :integer, default: 1
    add_column :accounts, :picture, :string
    add_column :accounts, :phone_number, :string
    add_column :accounts, :description, :text
    add_column :accounts, :address, :string
    add_column :accounts, :city, :string
    add_column :accounts, :country, :string
    add_column :accounts, :post_code, :string
  end
end
