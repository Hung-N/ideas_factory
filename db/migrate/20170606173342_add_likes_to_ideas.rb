class AddLikesToIdeas < ActiveRecord::Migration[5.1]
  def change
    add_column :ideas, :likes, :integer
  end
end
