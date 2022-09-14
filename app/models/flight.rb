class Flight < ApplicationRecord
  default_scope { where('departure_time > ?', DateTime.current).order(:departure_time) }

  validates :departure_time, presence: true
  validates :duration_in_min, presence: true, length: { minimum: 1 }

  belongs_to :departure_airport, class_name: 'Airport', inverse_of: :departure_flights
  belongs_to :arrival_airport, class_name: 'Airport', inverse_of: :arrival_flights 
end
