class PiecesController < ApplicationController
  include Rails.application.routes.url_helpers
  require_relative '../models/gpt'
  before_action :authenticate_user!
  before_action :set_piece, only: %i[show edit update destroy create_description]

  def index
    @pieces = current_user.pieces.reverse_order
    random
  end

  def show
    @booking = Booking.new
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

  def create_description
    if @piece.photos.attached?
      photo_url = "https://res.cloudinary.com/dvnfimkfd/image/upload/c_fill,h_300,w_400/v1/development/#{@piece.photos.first.key}?_a=BACCd2Bn"

      # Get the description from OpenAI API
      description = Gpt.gpt_call("Describe the thing you see in the picture in english. Keep it brief and make it suitable for a platform like Kleiderkreisel. Don't mention size or fabric:", photo_url)
      @piece.update(description: description)

      redirect_to @piece, notice: 'Description was successfully created.'
    else
      redirect_to @piece, alert: 'No photos attached to create a description.'
    end
  end

  private

  def random
    random_piece = Piece.joins(:user).where.not(user_id: current_user.id).order("RANDOM()").limit(5)
    @random_piece = random_piece
  end

  def set_piece
    @piece = Piece.find(params[:id])
  end

  def piece_params
    params.require(:piece).permit(:name, :color, :description, photos: [])
  end

  def generate_cloudinary_url(photo_key)
    Cloudinary::Utils.cloudinary_url(photo_key)
  end
end
