class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :page, index: true
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :message
      t.string :is_processed, default: 'n'
      t.string :note

      t.timestamps
    end
    add_index :books, :is_processed
  end
end
