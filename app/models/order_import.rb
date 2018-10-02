class OrderImport < Import
  def row_importer_class
    OrderRowImporter
  end
end
