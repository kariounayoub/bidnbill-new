class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :company
      t.text :message
      t.string :phone

      t.timestamps
    end
  end
end
