class ItemSearchSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category, :image_medium, :image_thumb

  def category
    object.category.title
  end

  def image_medium
    object.picture.url(:medium)
  end

  def image_thumb
    object.picture.url(:thumb)
  end
end
