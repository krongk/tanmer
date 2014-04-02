class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|
      t.references :page
      t.string :ip

      t.timestamps
    end
    add_index :ip_addresses, [:page_id, :ip]
  end
end
