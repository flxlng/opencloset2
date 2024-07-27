class AddDescriptionToPieces < ActiveRecord::Migration[7.1]
  def change
    add_column :pieces, :description, :text
  end
end
