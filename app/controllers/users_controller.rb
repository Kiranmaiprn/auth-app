class UsersController  < ApplicationController


    def index
        @users = User.all
        render json: @users.pluck(:email)
    end

    
    


end