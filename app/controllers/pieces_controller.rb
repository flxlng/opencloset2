class PiecesController < ApplicationController
  before_action :set_piece, only: [:show, :edit, :update, :destroy]

  def index
    @pieces = Piece.all
  end

  def show
  end

  def new
    @piece = Piece.new
  end

  def edit
  end

  def create
    @piece = Piece.new(piece_params)

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
