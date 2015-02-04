class CreateBirds < ActiveRecord::Migration
  def up
    create_table :birds do |t|
      t.string :name
      t.integer :wingspan
      t.string :image_url
      t.timestamps
    end
  end

  def down
    drop_table :birds
  end
end
