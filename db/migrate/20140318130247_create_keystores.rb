class CreateKeystores < ActiveRecord::Migration
  def change
    create_table :keystores do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
    add_index :keystores, :key, unique: true
  end
end
