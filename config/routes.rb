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
    get '/:degree_type', to: 'submissions#dashboard', as: :submissions_dashboard
    get '/:degree_type/format_review_incomplete', to: 'submissions#format_review_incomplete', as: :submissions_format_review_incomplete
    root to: redirect(path: "/admin/#{Degree.default_degree_type}"), as: :dashboard
  end

  namespace :author do
    resources :authors, except: [:index, :show, :destroy]
    resources :submissions, except: [:show] do
      get '/format_review', to: 'submissions#format_review', as: :format_review
      patch '/format_review', to: 'submissions#update_format_review', as: :update_format_review
      resource :committee, except: [:show, :destroy]
    end
    root to: 'submissions#index'
  end

  root :to => 'static#home'

  get    '/mockups/:page' => 'mockups#show', as: :mockup

end
