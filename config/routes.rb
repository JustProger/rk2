Rails.application.routes.draw do
  get 'rkmain/input'
  get 'rkmain/show'
  root "rkmain#input"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
