class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false, default: ''

      t.timestamps
    end
  end
end
