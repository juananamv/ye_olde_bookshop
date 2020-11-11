ActiveAdmin.register Product do
  permit_params :name, :description, :price, :quantity, product_tags_attributes: [:id, :product_id, :category_id]

  index do
    selectable_column
    column :id
    column :name
    column :price
    column :categories do |product|
      product.categories.map { |p| p.name }.join(", ").html_safe
    end
    actions
  end

  show do |product|
    attributes_table do
      row :name
      row :description
      row :price
      row :categories do |product|
        product.categories.map { |p| p.name }.join(", ").html_safe
      end
    end
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs "Product" do
      f.input :name
      f.input :description
      f.input :price
      f.input :quantity
      f.has_many :product_tags, allow_destroy: true do |n_f|
        n_f.input :category
      end
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
