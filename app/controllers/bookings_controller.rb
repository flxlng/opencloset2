class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
  end

  def new
    @booking = Booking.new
  end

  def create
    start_date = params[:booking][:start_date]
    end_date = params[:booking][:end_date]
    @piece = Piece.find(params[:piece_id])
    @booking = Booking.new(booking_params)
    @booking.start_date = start_date
    @booking.end_date = end_date
    @booking.piece = @piece
    @booking.user = current_user
    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Booking was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_url, notice: 'Booking was successfully destroyed.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:user_id, :piece_id, :start_date, :end_date)
  end
end
