ActiveAdmin.register Movie do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  permit_params :title

  controller do
    def create
      @movie = Movie.new(permitted_params[:title])
      if @movie.save
      end
    end
  end

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
