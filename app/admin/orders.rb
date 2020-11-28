ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :date, :status, :user_id, :gst, :pst, :stripe_session
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :status, :user_id, :gst, :pst, :stripe_session]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
