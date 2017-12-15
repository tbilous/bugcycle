class AddPictureColumnToSuggestions < ActiveRecord::Migration[5.1]
  def up
    add_attachment :suggestions, :picture
  end

  def down
    remove_attachment :suggestions, :picture
  end
end
