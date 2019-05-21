class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.references :bill, foreign_key: true
      t.references :user, foreign_key: true
      t.string :status
      t.text :content
      t.float :price
      t.boolean :needs_editing, default: false
      t.boolean :provider_notification_sent, default: false
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
