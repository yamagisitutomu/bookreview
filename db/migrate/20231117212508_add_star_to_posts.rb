class AddStarToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :ster, :string
  end
end
