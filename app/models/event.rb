class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :event_happenings, foreign_key: :attended_event_id
  has_many :attendees, through: :event_happenings
  scope :past, -> { where('date < ?', Date.today).order(date: :desc)}
  scope :future, -> { where('date > ?', Date.today).order(:date)}
end
