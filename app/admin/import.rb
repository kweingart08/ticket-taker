ActiveAdmin.register Import do
  config.filters = false

  index do
    column 'Status' do |import|
      link_to import.display_status, admin_import_path(import)
    end
    column 'File Uploaded' do |import|
      link_to import.file_file_name, import.file.url
    end
    column 'Records' do |import|
      import.number_of_records_imported
    end
    actions
  end

  show do
    attributes_table do
      row 'Status' do |import|
        import.display_status
      end
      row 'Errors' do |import|
        if import.failed?
          ul do
            import.formatted_errors.each do |error|
              li style: 'color:red;' do
                error
              end
            end
          end
        else
          'None'
        end
      end
      row 'File Uploaded' do |import|
        link_to import.file_file_name, import.file.url
      end
      row 'Records Imported' do |import|
        import.number_of_records_imported
      end
    end
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    if f.object.failed?
      panel "Errors" do
        ul do
          f.object.formatted_errors.each do |error|
            li style: 'color:red;' do
              error
            end
          end
        end
      end
    end

    panel "1. Download Template CSV" do
      # link to template file that should be in public/
      link_to 'Download Template CSV', '/example.csv'
    end

    f.inputs "2. Import CSV" do
      f.input :file, :as => :file, :hint => f.object.file_file_name
    end
    f.actions
  end

  controller do
    def process_success
      notice = @import.processing? ? 'Your import is being processed' : 'Your import is complete'
      redirect_to admin_import_path(@import), notice: notice
    end

    def create
      @import = OrderImport.new(order_import_params)
      return render :new unless @import.save

      if @import.import!
        process_success
      else
        return redirect_to edit_admin_import_path(@import)
      end
    end

    def update
      @import = OrderImport.find(params[:id])
      @import.attributes = order_import_params || {}
      return render :edit unless @import.save

      if @import.import!
        process_success
      else
        return render :edit
      end
    end

    private

    def order_import_params
      params.require(:import).permit(:file)
    end

  end
end
