class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user, index: true
      t.decimal :price, :precision => 8, :scale => 2
      t.string :state
      t.datetime :pending_at
      t.datetime :completed_at
      t.datetime :canceled_at
      t.datetime :paid_at
      t.string :trade_no
      t.string :note

      t.timestamps
    end
  end
end
