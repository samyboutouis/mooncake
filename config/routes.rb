Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "dashboard#index"
  get "/student" => "user#show", as: "student_show"
  get '/oauth/login' => 'authentication#login' 
  get '/oauth/callback' => 'authentication#callback'
  delete '/logout', to: 'authentication#destroy'
end
