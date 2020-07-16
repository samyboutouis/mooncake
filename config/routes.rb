Rails.application.routes.draw do
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "dashboard#index"
  get "/faculty" => "dashboard#faculty_index", as: "faculty_page"
  get "/publish/:course" => "dashboard#publish", as: "publish_page"
  get "/facreqview/:course" => "dashboard#facreqview", as: "requests_page"
  get "/allrequests" => "dashboard#allrequests", as: "allrequests"

  # Facreqview
  get "/deny/:request" => "facreqview#deny", as: "deny"
  get "/accept/:request" => "facreqview#accept", as: "accept"
  get "/accept_selected"  => "facreqview#accept_selected"
  get "/deny_selected"  => "facreqview#deny_selected"
  get "/permnum/:req" => "facreqview#addpermnum", as: "add_permnum"
  post "/add" => "facreqview#add", as: "add"
  get "/mailing/:request" => "facreqview#mailing", as: "send_mailer"
  get "/mailingall/:course" => "facreqview#mailingall", as: "send_all_mailer"
  get "/mailing2" => "facreqview#mailing2"
  get "/mailingall2" => "facreqview#mailingall2"
  get "/mailselected" => "facreqview#mailselected"
  get "/mailselected2" => "facreqview#mailselected2"

  # AllRequests

  get "/denyview/:request" => "allrequest#denyview", as: "denyview"
  get "/acceptview/:request" => "allrequest#acceptview", as: "acceptview"
  get "/all_accept_selected"  => "allrequest#all_accept_selected"
  get "/all_deny_selected"  => "allrequest#all_deny_selected"
  get "/reqmailingall" => "allrequest#reqmailingall", as: "send_allreq_mailer"
  get "/reqmailingall2" => "allrequest#reqmailingall2"
  get "/allmailselected" => "allrequest#allmailselected"
  get "/allmailselected2" => "allrequest#allmailselected2"

  # Permission 
  
  get "/addpermnum/:course" => "permission#addmorepermnum", as: "add_more_permnum"
  post "/addmore" => "permission#addmore", as: "add_more"
  get "/numbers/:course" => "permission#numbers", as: "numbers"


  #Ranking
  get "/rank1/:request" => "dashboard#rank1", as: "rank1"
  get "/rank2/:request" => "dashboard#rank2", as: "rank2"
  get "/rank3/:request" => "dashboard#rank3", as: "rank3"


  delete "/withdraw/:request" => "dashboard#withdraw" , as: "withdraw_request"
  get "/requestform/:request" => "dashboard#view" , as: "request_form"
  get "/student" => "user#show", as: "student_show"
  get '/oauth/login' => 'authentication#login', as: "app_login"
  get '/oauth/callback' => 'authentication#callback'
  delete '/logout', to: 'authentication#destroy'
  # get '/request' => 'course_request#expand'
  get '/ldap' => 'authentication#authorize', as: 'ldap'

  #answer routes
  get '/form/:course_request'=> 'answer#form', as: "answer"
  get '/data'=> 'answer#data', as: "data"

  #faculty creating questions routes
  get '/questions/:course'=> 'questions#create_form', as: "question"
  put '/questions/:course' => 'questions#create', as: "questions"
  get '/questions/:course/new' => 'questions#new', as: "new_question"
  delete '/questions/:id' => 'questions#delete', as: "delete_question"
  get '/options' => 'questions#options'

  #student requests a permission number
  get '/search' => 'course_request#index', as: "search"
  get '/term' => 'course_request#term'
  get '/department' => 'course_request#department'
  get '/section' => 'course_request#section'
  get '/courserequests' => 'course_request#submit'
  get '/courserequests/new' => "course_request#new", as: "new_course_request"

  #create course routes
  get '/courses/new' => "courses#new", as: "new_course"
  get '/dept' => "courses#departments", as: "dept"
  post '/courses' => "courses#create"
  delete '/courses/:id' => 'courses#delete', as: "delete_course"

  #faq
  get '/faq' => "faq#show", as: "faq"
end
