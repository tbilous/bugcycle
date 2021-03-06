class SearchesController < ApplicationController
  respond_to :json

  def search
    @items = Item.includes(:category).searchable.things_of_other(current_user).search(params)
    respond_with @items, each_serializer: ItemSearchSerializer
  end
end
