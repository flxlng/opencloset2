class PiecesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_piece, only: %i[show edit update destroy]

  def index
    @pieces = current_user.pieces.reverse_order
  end

  def show
  end

  def new
    @piece = current_user.pieces.build
  end

  def edit
  end

  def create
    @piece = current_user.pieces.build(piece_params)
    if @piece.save
      redirect_to @piece, notice: 'Piece was successfully created.'
    else
      render :new
    end
  end

  def update
    if @piece.update(piece_params)
      redirect_to @piece, notice: 'Piece was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @piece.destroy
    redirect_to pieces_url, notice: 'Piece was successfully destroyed.'
  end

  private

  def set_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:name, :color, :description, photos: [])
  end
end
