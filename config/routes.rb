Rails.application.routes.draw do
  get 'home/index'
  get 'home/confirm', to: "home#confirm"
  get 'home/submit', to: "home#submit"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #ERJ 9/11/2024 added devise_for
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/unauth', :to => redirect('/unauth.html'), as: :unauth

end
