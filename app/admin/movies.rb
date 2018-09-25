ActiveAdmin.register Movie do

  permit_params :title

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

# on the show page show all showtimes affiliated with that movie
  show do
    attributes_table do
      row :id
      row :title
    end

    panel "Showtimes for #{title}" do
      render 'movie_list', layout: "application"
    end
  end

end
