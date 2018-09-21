ActiveAdmin.register Movie do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


  index do
    column :id
    column :title
    actions
  end

  form do |f|
    f.inputs "New Movie" do
      f.input :title
    end
    f.actions
  end

end
