class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.references :page, index: true
      t.text :content
    end
  end
end
