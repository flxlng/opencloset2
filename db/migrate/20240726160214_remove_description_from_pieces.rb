class RemoveDescriptionFromPieces < ActiveRecord::Migration[7.1]
  def change
    remove_column :pieces, :description, :string
  end
end
