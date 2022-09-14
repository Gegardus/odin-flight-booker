class Flight < ApplicationRecord
  default_scope { where('departure_time > ?', DateTime.current).order(:departure_time) }

  validates :departure_time, presence: true
  validates :duration_in_min, presence: true, length: { minimum: 1 }

  belongs_to :departure_airport, class_name: 'Airport', inverse_of: :departure_flights
  belongs_to :arrival_airport, class_name: 'Airport', inverse_of: :arrival_flights 

  has_many :bookings

  def self.search(params)
    target_date = array_to_date(params['time(2i)'], params['time(3i)'], params['time(1i)'])

    Flight.where(
      arrival_airport_id: params[:arrival_airport_id],
      departure_airport_id: params[:departure_airport_id],
      departure_time: (target_date.beginning_of_day..target_date.end_of_day)
    )
  end

  def self.array_to_date(month, day, year)
    DateTime.new(year.to_i, month.to_i, day.to_i)
  end

  def departure_date
    departure_time.strftime('%B %d, %Y')
  end

  def departure_hour
    departure_time.strftime('%I:%M %p')
  end

  def arrival_hour
    (departure_time + duration_in_min.minutes).strftime('%I:%M %p')
  end

  def duration_in_words
    "#{duration_in_min / 60} hr #{duration_in_min % 60} min"
  end
end
