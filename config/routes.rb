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

    get '/submissions/:id/edit', to: 'submissions#edit', as: :edit_submission
    patch '/submissions/:id/format_review_response', to: 'submissions#record_format_review_response', as: :submissions_format_review_response

    get '/:degree_type', to: 'submissions#dashboard', as: :submissions_dashboard

    get '/:degree_type/format_review_incomplete', to: 'submissions#format_review_incomplete', as: :submissions_format_review_incomplete
    delete '/:degree_type/format_review_incomplete', to: 'submissions#bulk_destroy', as: :submissions_delete_format_review_incomplete

    get '/:degree_type/format_review_submitted', to: 'submissions#format_review_submitted', as: :submissions_format_review_submitted

    get '/:degree_type/final_submission_incomplete', to: 'submissions#final_submission_incomplete', as: :submissions_final_submission_incomplete

    root to: redirect(path: "/admin/#{Degree.default_degree_type}"), as: :dashboard
  end

  namespace :author do
    resources :authors, except: [:index, :show, :destroy]
    resources :submissions, except: [:show] do
      get '/format_review/edit', to: 'submissions#edit_format_review', as: :edit_format_review
      patch '/format_review', to: 'submissions#update_format_review', as: :update_format_review

      get '/final_submission', to: 'submissions#final_submission', as: :final_submission
      patch '/final_submission', to: 'submissions#update_final_submission', as: :update_final_submission

      resource :committee, except: [:show, :destroy]
    end
    root to: 'submissions#index'
  end

  root :to => 'static#home'

  get    '/mockups/:page' => 'mockups#show', as: :mockup

end
