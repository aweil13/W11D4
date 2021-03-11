class Api::SessionController < ApplicationController
    
    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user
            login(@user)
            render 'api/users/show'
        else
            render json: ['Wrong credentials'], status: 401
        end
    end

    def destroy
        render json: ['Not found'], status: 404 unless @current_user
        logout!
        render json: {}
    end
end
