class AddInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :user_type, :string
    add_column :users, :company, :string
    add_column :users, :phone_number, :string
    add_column :users, :photo, :string
    add_column :users, :admin, :boolean
    add_column :users, :days_since_last_provider_email, :integer, default: 1
    add_reference :users, :account
  end
end
