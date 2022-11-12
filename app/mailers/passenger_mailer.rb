class PassengerMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @booking = Booking.find(params[:booking_id])
    @url = booking_url(@booking)
    mail(to: @booking.passengers.pluck(:email),
         subject: "Thank you for booking Flight, and Welcome onboard at mentioned datetime! #{@booking.flight_id}!")
  end
end
