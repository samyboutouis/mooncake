class FormController < ApplicationController
    def form 
        @user = $current_user
    end

    def data
        # retrieve data using param
        @user = $current_user
        puts params["major"]
        redirect_to root_url
    end
end