Rails.application.routes.draw do
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "dashboard#index"
  get "/faculty" => "dashboard#faculty_index", as: "faculty_page"
  get "/publish/:course" => "dashboard#publish", as: "publish_page"
  get "/facreqview/:course" => "dashboard#facreqview", as: "requests_page"
  get "/numbers/:course" => "dashboard#numbers", as: "numbers"
  get "/allrequests" => "dashboard#allrequests", as: "allrequests"

  #Accept/Deny
  get "/deny/:request" => "dashboard#deny", as: "deny"
  get "/accept/:request" => "dashboard#accept", as: "accept"
  get "/permnum/:req" => "dashboard#addpermnum", as: "add_permnum"
  post "/add" => "dashboard#add", as: "add"
  get "/denyview/:request" => "dashboard#denyview", as: "denyview"
  get "/acceptview/:request" => "dashboard#acceptview", as: "acceptview"
  get "/accept_selected"  => "dashboard#accept_selected"
  get "/deny_selected"  => "dashboard#deny_selected"
  get "/addpermnum/:course" => "dashboard#addmorepermnum", as: "add_more_permnum"
  post "/addmore" => "dashboard#addmore", as: "add_more"

  #Custom Mailing
  get "/mailing/:request" => "mailing#mailing", as: "send_mailer"
  get "/mailingall/:course" => "mailing#mailingall", as: "send_all_mailer"
  get "/mailing2" => "mailing#mailing2"
  get "/mailingall2" => "mailing#mailingall2"
  get "/reqmailingall" => "mailing#reqmailingall", as: "send_allreq_mailer"
  get "/reqmailingall2" => "mailing#reqmailingall2"
  get "/mailselected" => "mailing#mailselected"
  get "/mailselected2" => "mailing#mailselected2"
  get "/allmailselected" => "mailing#allmailselected"
  get "/allmailselected2" => "mailing#allmailselected2"

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
