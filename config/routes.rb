Rails.application.routes.draw do
  devise_for :users
  resources :products, only: %i[index show]
  resources :categories, only: %i[index show]
  root "products#index"
  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  post "products/increase_quantity/:id", to: "products#increase_quantity", as: "increase_quantity"
  post "products/decrease_quantity/:id", to: "products#decrease_quantity", as: "decrease_quantity"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"
  get "users/my_orders", to: "users#my_orders", as: "my_orders"
  get "/checkout", to: "checkout#index", as: "checkout"

  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
