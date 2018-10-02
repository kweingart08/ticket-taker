class CreateImports < ActiveRecord::Migration[5.2]
  def change
    create_table :imports do |t|
      t.string :status
      t.text :results
      t.string :type
      t.attachment :file
      t.boolean :should_replace

      t.timestamps
    end
  end
end
