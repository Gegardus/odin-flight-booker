Rails.application.routes.draw do
  get 'bookings/new'
  get 'bookings/show'
  get 'flights/index'
 
  resources :flights, only: %i[index]
  resources :bookings, only: %i[new create show]
  root "flights#index"
end
