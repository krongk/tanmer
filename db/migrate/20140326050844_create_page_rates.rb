class CreatePageRates < ActiveRecord::Migration
  def change
    create_table :page_rates do |t|
      t.references :page, index: true
      t.references :member, index: true
      t.integer :rate_count
      t.string :message
      t.timestamps
    end
  end
end
