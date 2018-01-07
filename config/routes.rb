Rails.application.routes.draw do
  resources :stock_infos
  resources :stocks
  get 'strategies/timing'

  get 'strategies/momentum'

  get 'welcome/index'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
