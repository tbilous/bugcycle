class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :category, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title, null: false, default: ''
      t.string :description, null: false, default: ''

      t.timestamps
    end
  end
end
