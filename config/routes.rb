Rails.application.routes.draw do

  root :to => "catalog#index"
  blacklight_for :catalog
  devise_for :users

  get '/home' => 'static#home', as: :home

end
