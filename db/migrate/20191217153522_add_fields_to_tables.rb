class AddFieldsToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_valid, :boolean, default: false

    add_column :bills, :pdl, :string
    add_column :bills, :energie_verte, :boolean

    add_column :bids, :methode_contact, :string
  end
end
