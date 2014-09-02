class CreatePageImages < ActiveRecord::Migration
  def change
    create_table :page_images do |t|
      t.references :page, index: true
      t.timestamps
    end
    add_attachment :page_images, :image
  end
end
