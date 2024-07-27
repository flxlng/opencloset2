class AddDetailsToPieces < ActiveRecord::Migration[7.1]
  def change
    add_column :pieces, :type, :string
    add_column :pieces, :brand, :string
  end
end
