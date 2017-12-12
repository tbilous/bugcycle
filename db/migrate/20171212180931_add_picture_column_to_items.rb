class AddPictureColumnToItems < ActiveRecord::Migration[5.1]
  def up
    add_attachment :items, :picture
  end

  def down
    remove_attachment :items, :picture
  end
end
