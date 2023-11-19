class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books, id: false do |t|
      t.string :title
      t.string :author
      t.bigint :isbn, null: false
      t.string :image_url
      t.string :sales_date
      
      t.timestamps
    end
  end
end
