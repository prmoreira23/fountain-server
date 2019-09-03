Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :update]

  resources :job_openings, only: [:index, :show, :create, :update] do
    get 'latest_jobs', on: :collection
    post 'apply_to_job', on: :member
  end

  post '/auth/login', to: 'authentication#login'
  get 'users', to: 'users#show'
  get 'job_applications', to: 'job_applications#index'

  get '/*a', to: 'application#not_found'
end
