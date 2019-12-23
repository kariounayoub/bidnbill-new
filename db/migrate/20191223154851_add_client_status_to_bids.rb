class AddClientStatusToBids < ActiveRecord::Migration[5.2]
  def change
    add_column :bids, :client_status, :string
  end
end
