class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.integer :place_id, null: false
      t.text :caption
      t.timestamps
    end
  end
end
