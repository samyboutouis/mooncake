class FormController < ApplicationController
    def form 
    end

    def data
        # retrieve data using param
        puts params["email"]
        redirect_to root_url
    end
end