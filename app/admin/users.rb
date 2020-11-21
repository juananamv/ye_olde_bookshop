ActiveAdmin.register User do
  permit_params :username, :password, :salt, :address, :city, :province_id, :postal_code

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :province
      f.input :username
      f.input :password
      f.input :address
      f.input :city
      f.input :postal_code
    end
    f.actions
  end
end