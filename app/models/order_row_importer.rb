class OrderRowImporter < CSVImportable::RowImporter
  def import_row
    order = Order.create(
      showtime_id: pull_string('showtime_id', required: true),
      email: pull_string('email', required: true),
      credit_card_number: pull_string('credit_card_number', required: true),
      expiration_date: pull_string('expiration_date'),
      quantity: pull_float('quantity'),
      name: pull_string('name')
    )
  end
end
