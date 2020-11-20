class ProductsController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

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
      @header = "#{@products.count} for '#{params['query']}' in '#{Category.find(params['category']).name}'"
    end
  end

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i.zero? ? 1 : params[:quantity].to_i

    session[:cart][id.to_s] = quantity unless session[:cart].key?(id)
    redirect_to root_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id.to_s)

    redirect_to root_path
  end

  def increase_quantity
    session[:cart][params[:id].to_s] += 1
    redirect_to root_path
  end

  def decrease_quantity
    session[:cart][params[:id].to_s] -= 1
    redirect_to root_path
  end

  def show
    @product = Product.find(params[:id])
  end

  private

  def initialize_session
    session[:cart] ||= {}
  end

  def load_cart
    array = session[:cart].keys
    @cart = Product.find(array)
  end
end
