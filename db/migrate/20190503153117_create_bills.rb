class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.references :user, foreign_key: true
      t.string :current_provider
      t.string :address
      t.float :price
      t.string :photo
      t.references :category, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.integer :consumption
      t.string :city
      t.string :zip_code

      t.boolean :is_deleted
      t.boolean :is_edited
      t.boolean :is_open
      t.boolean :send_update_email
      t.integer :days_without_mail, default: 1

      t.timestamps
    end
  end
end
