Rails.application.routes.draw do
  get 'home/index'
  get 'home/confirm', to: "home#confirm"
  get 'home/submit', to: "home#submit"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
