class ChangeIsbnTypeInBooks < ActiveRecord::Migration[6.1]
  def up
    change_column :books, :isbn, :string
  end

  def down
    change_column :books, :isbn, :bigint
  end
end
