class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.integer :number
      t.string :title
      t.boolean :seen, default: false
      t.boolean :aired, default: false
      t.text :description
      t.integer :season_id

      t.timestamps
    end
  end
end
