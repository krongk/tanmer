class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.references :user, index: true
      t.string :title
      t.string :keywords
      t.string :description
      t.text :content
      t.string :qrcode
      t.string :short_title
      t.string :properties
      t.integer :amount
      t.decimal :price
      t.integer :view_count, default: 0
      t.integer :fav_count, default: 0
      t.string :is_processed, default: 'n'

      t.timestamps
    end
    add_index :pages, :title
    add_index :pages, :is_processed
    add_index :pages, [:user_id, :short_title], unique: true
  end
end
