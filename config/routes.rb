Rails.application.routes.draw do
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "dashboard#index"
  get "/faculty" => "dashboard#faculty_index"
  get "/student" => "user#show", as: "student_show"
  get '/oauth/login' => 'authentication#login' 
  get '/oauth/callback' => 'authentication#callback'
  delete '/logout', to: 'authentication#destroy'
  get '/request' => 'course_request#show' 
  get '/ldap' => 'authentication#authorize', as: 'ldap_path'
  get '/form'=> 'form#form'
  get '/data'=> 'form#data'

  #student requests a permission number
  get '/search' => 'course_request#search', as: "search"
  get '/department' => 'course_request#department'

  #create course routes
  get '/courses' => "courses#index"
  get '/courses/new' => "courses#new"
  post '/courses' => "courses#create"
  get '/courses/:id' => "courses#show"
end
