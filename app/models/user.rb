class User < ApplicationRecord
  has_many :pieces, dependent: :destroy
  has_many :bookings
  has_many :booked_pieces, through: :bookings, source: :piece
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
