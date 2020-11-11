class ProductsController < ApplicationController
  def index
    if params["query"].nil? || params["query"] == ''
      @products = Product.order('name ASC')
      @header = "All Products"
    else
      @products = Product.left_outer_joins(:categories)
                         .where("products.name LIKE '%#{params['query']}%' OR categories.name LIKE '%#{params['query']}%'")
      @header = "#{@products.count} results found for '#{params['query']}'"
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
