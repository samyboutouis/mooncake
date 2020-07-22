class AuthenticationController < ApplicationController

    skip_before_action :require_login, only: [:login, :callback]
    # skip_before_action :faculty_check
    # skip_before_action :student_check
    def login
      client = OAuth2::Client.new(
        'mooncake',
        ENV["MOONCAKE_OAUTH_KEY"],
        :site => "https://oauth.oit.duke.edu/oidc",
        :authorize_url =>  "/oidc/authorize",
        :token_url =>  "/oidc/token"
      )
      redirect_to client.auth_code.authorize_url(:redirect_uri => ENV["MOONCAKE_OAUTH_REDIRECT"])

    end

    def callback
      auth_code = params["code"] 
      client = OAuth2::Client.new(
        'mooncake',
        ENV["MOONCAKE_OAUTH_KEY"],
        :site => "https://oauth.oit.duke.edu/oidc",
        :authorize_url =>  "/oidc/authorize",
        :token_url =>  "/oidc/token"
      )      
      token = client.auth_code.get_token(auth_code, :redirect_uri => ENV["MOONCAKE_OAUTH_REDIRECT"])
      user_info = token.get("/oidc/userinfo")
      user_info = JSON.parse(user_info.body)
      puts "********"
      puts user_info
      session[:user_id] = user_info['dukeNetID']
      unless User.exists?(net_id: session[:user_id])
        User.create(first_name: user_info['given_name'], last_name: user_info['family_name'], net_id: user_info['dukeNetID'], unique_id: user_info['dukeUniqueID'], email: user_info["email"])
        #UserMailer.with(email: user_info["email"]).welcome_email.deliver_now
      end  
      session[:current_user] = User.find_by(net_id: session[:user_id])
      redirect_to ldap_path
      #redirect_to root_url
      # redirect_to 'http://localhost:3000/oauth/logout' 
    end

    def destroy
      # Resets session
      reset_session
      redirect_to 'https://oauth.oit.duke.edu/oidc/logout.jsp'
    end

    def authorize
      ldap = Net::LDAP.new
      ldap.host = "ldap.duke.edu"
      base = "dc=duke,dc=edu"
      ldap.port = 389

      netid = session[:current_user]["net_id"]
      filter = Net::LDAP::Filter.eq( "uid", netid )

      result = ldap.search( :base => base, :filter => filter )
      
      ldap.get_operation_result
      puts session[:current_user]
      information = result.pop
      affiliation = information["edupersonprimaryaffiliation"].join(' ')
      session[:current_user]["grad_year"] = information["dupsexpgradtermc1"].join(' ')
      session[:current_user]["email"] = information["edupersonprincipalname"].join(' ')
      
      User.find_by(net_id: netid).update(grad_year: session[:current_user]['grad_year'], user_type: affiliation)
      # User.find_by(net_id: session[:current_user]["net_id"]).update(email: session[:current_user]["email"])
      if affiliation.include? 'staff' 
        session[:current_user]["user_type"] = 'staff' 
        redirect_to faculty_page_path
      elsif affiliation.include? 'faculty'
        session[:current_user]["user_type"] = 'faculty' 
        redirect_to faculty_page_path
      else
        session[:current_user]["user_type"] = 'student'
        redirect_to root_url
      end
  end
end
