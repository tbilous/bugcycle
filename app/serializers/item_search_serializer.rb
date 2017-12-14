class ItemSearchSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :category, :image_medium, :image_thumb, :filter, :user_id

  def category
    object.category.title
  end

  def image_medium
    object.picture.url(:medium)
  end

  def image_thumb
    object.picture.url(:thumb)
  end

  def filter
    object.black_lists.present? ? object.black_lists.take.id : 0
  end
end
