class CategoriesController < ApplicationController
  before_action :load_category, only: %i(update destroy show edit)

  authorize_resource

  def create
    respond_with @category = current_user.categories.create(strong_params)
  end

  def update
    @category.update(strong_params)
    respond_with @category
  end

  def destroy
    respond_with @category.destroy
  end

  def index
    respond_with @categories = Category.all
  end

  def show
    # @items = @category.items.page params[:page]
    @items = Kaminari.paginate_array(@category.items).page(params[:page]).per(10)
    respond_with @category
  end

  def new
    respond_with @category = Category.new
  end

  def edit
    respond_with @category
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def strong_params
    params.require(:category).permit(:title, :user_id)
  end
end
