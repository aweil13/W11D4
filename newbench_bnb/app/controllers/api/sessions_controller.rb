class Api::SessionsController < ApplicationController
    
    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user
            login!(@user)
            render 'api/users/show'
        else
            render json: ['Wrong credentials'], status: 401
        end
    end

    def destroy
       if logged_in?
        log_out
        render json: {}
       else
        render json: ['No user logged in'], status: 404
       end
    end
end
