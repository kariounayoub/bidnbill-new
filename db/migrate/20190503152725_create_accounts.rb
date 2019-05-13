class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :company
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
