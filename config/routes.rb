Rails.application.routes.draw do
  namespace :admin do
    get 'top/index'
  end
  get 'entry_images/index'
  get 'entry_images/new'
  get 'entry_images/edit'
  get 'entries/index'
  get 'entries/show'
  get 'entries/edit'
  get 'entries/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top#index"
  get "about" => "top#about", as: "about"

  1.upto(18) do |n|
    get "lesson/step#{n}(/:name)" => "lesson#step#{n}"
  end

  resources :members, only: [:index, :show] do
    get "search", on: :collection
    resources :entries, only: [:index]
  end
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:shoe, :edit, :update]
  resources :articles, only: [:index, :show]
  resources :entries do
    patch "like" , "unlike", on: :member
    get "voted", on: :collection
    resources :images, controller: "entry_images" do
      patch :move_higher, :move_lower, on: :member
    end
  end

  get "bad_request" => "top#bad_request"
  get "forbidden" => "top#forbidden"
  get "internal_server_error" => "top#internal_server_error"

  namespace :admin do
    root to: "top#index"
    resources :members do
      get "search", on: :collection
    end
    resources :articles
  end
end
