Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "dashboard#index"
  get "/faculty" => "dashboard#faculty_index"
  get "/student" => "user#show", as: "student_show"
  get '/oauth/login' => 'authentication#login' 
  get '/oauth/callback' => 'authentication#callback'
  delete '/logout', to: 'authentication#destroy'
  get '/request' => 'course_request#show' 
  get '/ldap' => 'authentication#authorize', as: 'ldap_path'

  #form routes
  get '/form'=> 'form#form'
  get '/data'=> 'form#data'

  #faculty creating questions routes
  get '/questions'=> 'questions#create_form', as: "question"
  post '/questions' => 'questions#create'
  get '/questions/new' => 'questions#new', as: "new_question_path"
  delete '/questions/:id' => 'questions#delete', as: "delete_question_path"

end

