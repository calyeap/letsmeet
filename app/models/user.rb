class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :events, class_name: 'Event', foreign_key: 'creator_id', dependent: :delete_all
  has_many :attendances
  has_many :events_as_attendee, through: :attendances, source: "event"
end