class AuthenticationController < ApplicationController

    skip_before_action :require_login, only: [:login, :callback]
    
    def login
      client = OAuth2::Client.new(
        'mooncake',
        'B8VCqtKGHRqBqZhwEWjJVoij1wWiXpGCYZjfx7olYUXRxcw_mN6ivhHehYu-jyDMWbnsuBEqSrYcCOF6X0G5qA',
        :site => "https://oauth.oit.duke.edu/oidc",
        :authorize_url =>  "/oidc/authorize",
        :token_url =>  "/oidc/token"
      )
      redirect_to client.auth_code.authorize_url(:redirect_uri => 'http://localhost:3000/oauth/callback')

    end

    def callback
      auth_code = params["code"] 
      client = OAuth2::Client.new(
        'mooncake',
        'B8VCqtKGHRqBqZhwEWjJVoij1wWiXpGCYZjfx7olYUXRxcw_mN6ivhHehYu-jyDMWbnsuBEqSrYcCOF6X0G5qA',
        :site => "https://oauth.oit.duke.edu/oidc",
        :authorize_url =>  "/oidc/authorize",
        :token_url =>  "/oidc/token"
      )      
      token = client.auth_code.get_token(auth_code, :redirect_uri => 'http://localhost:3000/oauth/callback')
      user_info = token.get("/oidc/userinfo")
      user_info = JSON.parse(user_info.body)
      session[:user_id] = user_info['dukeUniqueID'].to_i
      if User.exists?(unique_id: session[:user_id])
        $current_user = User.find_by(unique_id: session[:user_id])
      else
        $current_user = User.create(first_name: user_info['given_name'], last_name: user_info['family_name'], net_id: user_info['dukeNetID'], unique_id: user_info['dukeUniqueID'])
      end
      redirect_to ldap_path_url
      #redirect_to root_url
      # redirect_to 'http://localhost:3000/oauth/logout' 
    end

    def destroy
      # Resets session
      reset_session
     
      $current_user = nil
      redirect_to 'https://oauth.oit.duke.edu/oidc/logout.jsp'
    end

    def authorize
      ldap = Net::LDAP.new
      ldap.host = "ldap.duke.edu"
      base = "dc=duke,dc=edu"
      ldap.port = 389

      netid = $current_user.net_id
      filter = Net::LDAP::Filter.eq( "uid", netid )

      result = ldap.search( :base => base, :filter => filter )
      
      ldap.search( :base => base, :filter => filter )
      ldap.get_operation_result
          
      information = result.pop
      affiliation = information["edupersonprimaryaffiliation"]

      if affiliation.include? 'staff'
        $current_user.user_type = 'staff'
      else
        $current_user.user_type = 'student'
      end
      #byebug
      redirect_to root_url
    end
 

end
