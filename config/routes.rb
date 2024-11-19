Rails.application.routes.draw do
  get 'home/index'
  get 'home/confirm', to: "home#confirm"
  get 'home/submit', to: "home#submit"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'frames/index'
  get 'frames/confirm', to: "frames#confirm"
  get 'frames/submit', to: "frames#submit"
  get 'frames/new', to: "frames#new"

  get 'locnaf/index'
  get 'locnaf/listing', to: "locnaf#listing"
  get 'locnaf/lookup', to: "locnaf#lookup"
  get 'locnaf/confirm', to: "locnaf#confirm"

  #ERJ 9/11/2024 added devise_for
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/unauth', :to => redirect('/unauth.html'), as: :unauth

end
