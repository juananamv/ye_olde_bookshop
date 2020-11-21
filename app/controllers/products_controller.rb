class ProductsController < ApplicationController
  def index
    # Default
    if params["query"].nil? && params["category"].nil?
      @products = Product.all
      @header = "All Products"
    # Redirect default
    elsif params["query"] == "" && params["category"] == ""
      redirect_to products_path
    # Redirect to Category
    elsif params["query"] == "" && params["category"] != ""
      redirect_to Category.find(params["category"])
    # All product search
    elsif params["query"] != "" && params["category"] == ""
      @products = Product.where("name LIKE '%#{params['query']}%' OR description LIKE '%#{params['query']}%'")
      @header = "#{@products.count} #{@products.count == 1 ? 'result' : 'results'} for '#{params['query']}'"
    # Categorical search
    else
      @products = Product.left_outer_joins(:categories)
                         .where("categories.id =#{params['category']}")
                         .where("products.name LIKE '%#{params['query']}%' OR products.description LIKE '%#{params['query']}%'")
      @header = "#{@products.count} results for '#{params['query']}' in '#{Category.find(params['category']).name}'"
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
