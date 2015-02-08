class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.boolean :seen, default: false
      t.boolean :ended, default: false
      t.text :description
      t.integer :seasons_number

      t.timestamps
    end
  end
end
