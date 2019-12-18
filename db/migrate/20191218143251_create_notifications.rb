class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.references :bid, foreign_key: true
      t.boolean :seen
      t.string :category
      t.string :content

      t.timestamps
    end
  end
end
