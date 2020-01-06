Rails.application.routes.draw do
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

  resources :members do
    get "search", on: :collection
    resources :entries, only: [:index]
  end
  resource :session, only: [:create, :destroy]
  resource :account, only: [:show, :edit, :update]
  resource :password, only: [:shoe, :edit, :update]
  resources :articles
  resources :entries
end
