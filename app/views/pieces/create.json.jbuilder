if @piece.persisted?
  json.form render(partial: "pieces/form", formats: :html, locals: {piece: Piece.new})
  json.inserted_item render(partial: "pieces/piece", formats: :html, locals: {piece: @piece})
else
  json.form render(partial: "pieces/form", formats: :html, locals: {piece: @piece})
end
