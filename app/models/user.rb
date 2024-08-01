class User < ApplicationRecord
  has_many :pieces, dependent: :destroy
  has_many :bookings
  has_many :booked_pieces, through: :bookings, source: :piece
  has_many :bookings_as_owner, through: :pieces, source: :bookings

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
