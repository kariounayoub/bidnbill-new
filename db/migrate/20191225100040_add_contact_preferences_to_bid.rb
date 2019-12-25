class AddContactPreferencesToBid < ActiveRecord::Migration[5.2]
  def change
    add_column :bids, :contact_preferences, :string
  end
end
