Rails.application.routes.draw do

  devise_for :authors
    get '/logout', to: 'application#logout', as: :logout_author
    get '/login', to: 'application#login', as: :login_author

  namespace :admin do
    resources :programs, except: [:show, :destroy]
    resources :degrees,  except: [:show, :destroy]
    resources :authors,  except: [:new, :create, :show, :destroy]

    get '/submissions/:id/edit', to: 'submissions#edit', as: :edit_submission
    delete '/submissions', to: 'submissions#bulk_destroy', as: :delete_submissions

    patch '/submissions/:id/format_review_response', to: 'submissions#record_format_review_response', as: :submissions_format_review_response
    patch '/submissions/:id/final_submission_response', to: 'submissions#record_final_submission_response', as: :submissions_final_submission_response

    get '/:degree_type', to: 'submissions#dashboard', as: :submissions_dashboard

    get '/:degree_type/:scope', to: 'submissions#index', as: :submissions_index

    patch '/:degree_type/final_submission_approved', to: 'submissions#release_for_publication', as: :submissions_release_final_submission_approved

    root to: redirect(path: "/admin/#{Degree.default_degree_type}"), as: :dashboard
  end

  namespace :author do
    resources :authors, except: [:index, :show, :destroy]
    resources :submissions, except: [:show] do
      get '/program_information', to: 'submissions#program_information', as: :program_information

      get '/committee', to: 'submissions#committee', as: :committee

      get '/format_review', to: 'submissions#format_review', as: :format_review
      get '/format_review/edit', to: 'submissions#edit_format_review', as: :edit_format_review
      patch '/format_review', to: 'submissions#update_format_review', as: :update_format_review

      get '/final_submission', to: 'submissions#final_submission', as: :final_submission
      get '/final_submission/edit', to: 'submissions#edit_final_submission', as: :edit_final_submission
      patch '/final_submission', to: 'submissions#update_final_submission', as: :update_final_submission

      resource :committee, except: [:show, :destroy]
    end
    root to: 'submissions#index'
  end

  root :to => 'static#home'

  get    '/mockups/:page' => 'mockups#show', as: :mockup

end
