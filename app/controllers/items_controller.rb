class ItemsController < ApplicationController
  before_action :load_item, only: %i(update destroy show edit)
  before_action :load_category, only: %i(index new)

  def create
    @category = Category.find(params[:category_id])
    respond_with @item = @category.items.create(strong_params.merge(user_id: current_user.id))
  end

  def update
    @item.update(strong_params)
    respond_with @item
  end

  def destroy
    @category = Category.find(@item.category_id)
    respond_with(@category, @item.destroy)
  end

  def index
    @category = Category.find(params[:category_id])
    respond_with @items = @category.items
  end

  def show
    respond_with @item
  end

  def new
    respond_with @item = @category.items.new
  end

  def edit
    respond_with @item
  end

  private

  def load_category
    @category = Category.find(params[:category_id])
  end

  def load_item
    @item = Item.find(params[:id])
  end

  def strong_params
    params.require(:item).permit(:title, :description, :user_id)
  end
end
