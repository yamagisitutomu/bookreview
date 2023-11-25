class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :book, null: false#, primary_key: true
      t.references :customer, null: false#, primary_key: true
      t.string :star
      t.text :review
      t.timestamps
    end
    #add_foreign_key :posts, :books, column: :book_id , primary_key: :isbn
  end
end
