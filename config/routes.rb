Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'recipes#new'

  # resources :recipes, only: [:show]

  post '/recipes', to: 'recipes#index', as: 'recipe_list'

  get ':word', to: 'recipes#index', as: 'recipe_index'

  get '/recipes/:word/', to: 'recipes#show', as: 'recipe_detail'


end
