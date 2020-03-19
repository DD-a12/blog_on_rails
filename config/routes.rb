Rails.application.routes.draw do
  root 'posts#index'
  get '/users/:id/change_password' , to: 'users#change_password', as: 'change_password'
  patch '/users/:id/change_password', to: 'users#update_password'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:new , :create, :edit, :update]
  resource :session
end