Rails.application.routes.draw do

  get '/catalog' => "catalog#index"
  blacklight_for :catalog
  devise_for :users
  mount Hydra::Collections::Engine => '/'
  mount Worthwhile::Engine, at: '/'
  worthwhile_collections
  worthwhile_curation_concerns
  worthwhile_embargo_management

  namespace :admin do
    resources :programs, except: [:show, :destroy]
    resources :degrees,  except: [:show, :destroy]
    resources :authors,  except: [:new, :create, :show, :destroy]
    get '/', to: 'submissions#index', as: :dashboard
  end

  namespace :author do
    resources :authors, except: [:index, :show, :destroy]
    resources :submissions, except: [:show] do
      resource :committee, except: [:show, :destroy]
      resource :format_review, except: [:show, :edit, :update, :destroy]
    end
    root to: 'submissions#index'
  end

  root :to => 'static#home'

  get    '/mockups/:page' => 'mockups#show', as: :mockup

end
