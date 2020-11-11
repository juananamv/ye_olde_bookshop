class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def show
    # do a join thing
    @category = Category.find(params[:id])
  end
end
