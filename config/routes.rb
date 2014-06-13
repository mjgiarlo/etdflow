Rails.application.routes.draw do

  get '/catalog' => "catalog#index"
  blacklight_for :catalog
  devise_for :users
  mount Hydra::Collections::Engine => '/'
  mount Worthwhile::Engine, at: '/'
  worthwhile_collections
  worthwhile_curation_concerns
  worthwhile_embargo_management

  resources :programs, except: [:show, :destroy]
  resources :degrees,  except: [:show, :destroy]

  root :to => 'static#home'

  get    '/mockups/:page' => 'mockups#show', as: :mockup

end
