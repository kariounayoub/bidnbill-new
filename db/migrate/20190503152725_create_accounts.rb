class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :company
      t.string :company_type

      t.timestamps
    end
  end
end
