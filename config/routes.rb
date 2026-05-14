Rails.application.routes.draw do
  get 'home/index'
  get 'home/confirm', to: "home#confirm"
  get 'home/submit', to: "home#submit"
  get 'home/delete_lookup', to: "home#delete_lookup"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'frames/index'
  get 'frames/confirm', to: "frames#confirm"
  get 'frames/submit', to: "frames#submit"
  get 'frames/new', to: "frames#new"
  get 'frames/delete', to: "frames#delete"

  get 'locnaf/index'
  get 'locnaf/listing', to: "locnaf#listing"
  get 'locnaf/lookup', to: "locnaf#lookup"
  get 'locnaf/confirm', to: "locnaf#confirm"
  get 'locnaf/submit', to: "locnaf#submit"
  get 'locnaf/delete1', to: "locnaf#delete1"
  get 'locnaf/delete2', to: "locnaf#delete2"

  get 'artistimage/index'
  get 'artistimage/getconstituentdata', to: 'artistimage#getconstituentdata'
  get 'artistimage/confirm', to: 'artistimage#confirm'
  get 'artistimage/update', to: 'artistimage#update'

  #ERJ 9/11/2024 added devise_for
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/unauth', :to => redirect('/unauth.html'), as: :unauth

end
