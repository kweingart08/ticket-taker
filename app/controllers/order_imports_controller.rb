class OrderImportsController < ApplicationController
  def new
    @import = OrderImport.new
  end

  def create
    @import = OrderImport.new(order_import_params)
    process_import
  end

  def edit
    @import = OrderImport.find(params[:id])
  end

  def update
    @import = OrderImport.find(params[:id])
    @import.attributes = order_import_params
    process_import
  end

  def index
    @imports = OrderImport.all
  end

  private

    def process_import
      if @import.import!
        return redirect_to order_imports_path, notice: "The file is being imported."
      else
        return redirect_to edit_order_import_path(@import)
      end
    end

    def order_import_params
      params.require(:order_import).permit(:file)
    end
end
