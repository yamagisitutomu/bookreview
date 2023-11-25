class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books, id: false do |t|
      t.string :title
      t.string :author
      t.string :isbn, null: false
      t.string :image_url
      t.string :sales_date
      t.string :item_url
      
      t.timestamps
    end
  end
end
