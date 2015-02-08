class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :number
      t.boolean :seen, default: false
      t.boolean :ended, default: false
      t.text :description
      t.integer :episodes_number
      t.integer :show_id

      t.timestamps
    end
  end
end
