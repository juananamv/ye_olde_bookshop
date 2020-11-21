ActiveAdmin.register Product do
  permit_params :name, :description, :price, :quantity, :image, product_tags_attributes: %i[id product_id category_id]

  index do
    selectable_column
    column :id
    column :name
    column :price
    column :quantity
    column :categories do |product|
      product.categories.map { |p| p.name }.join(", ").html_safe
    end
    actions
  end

  show do |item|
    attributes_table do
      row :name
      row :description
      row :price
      row :quantity
      row :categories do |product|
        product.categories.map { |p| p.name }.join(", ").html_safe
      end
      row :image do
        item.image.present? ? image_tag(item.image) : "N/A"
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
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image) : ""
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
