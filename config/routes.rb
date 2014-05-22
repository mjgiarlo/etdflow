Rails.application.routes.draw do

  get '/catalog' => "catalog#index"
  blacklight_for :catalog
  devise_for :users

  root :to => 'static#home'

end
