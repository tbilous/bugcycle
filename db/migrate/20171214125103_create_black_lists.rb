class CreateBlackLists < ActiveRecord::Migration[5.1]
  def change
    create_table :black_lists do |t|
      t.integer :user_id
      t.integer :item_id, index: true

      t.timestamps
    end
    add_index :black_lists, %i[item_id user_id], unique: true
  end
end
