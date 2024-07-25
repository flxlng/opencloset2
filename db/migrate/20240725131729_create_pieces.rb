class CreatePieces < ActiveRecord::Migration[7.1]
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :color
      t.text :description

      t.timestamps
    end
  end
end
