Rails.application.routes.draw do

 #root :to => "catalog#index"
  get '/catalog' => "catalog#index"
  blacklight_for :catalog
  devise_for :users
  mount Hydra::Collections::Engine => '/'
  mount Worthwhile::Engine, at: '/'
  worthwhile_collections
  worthwhile_curation_concerns
  worthwhile_embargo_management

 #get '/home' => 'static#home', as: :home
  root :to => 'static#home'

end
