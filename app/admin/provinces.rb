ActiveAdmin.register Province do
  permit_params :name, :province_code, :gst, :pst
end
