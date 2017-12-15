class CreateSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :suggestions do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.integer    :author_id, index: true
      t.string     :title
      t.string     :description
      t.string     :item_picture

      t.timestamps
    end
  end
end
