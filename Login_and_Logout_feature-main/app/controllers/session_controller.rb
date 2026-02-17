class SessionController < ApplicationController
    def create
        email = params[:email]
        if email == JUser.find_by(email: email)&.email
            @current_user = JUser.find_by(email: params[:email])
            password = params[:password]

            profile_id = JUser.find(@current_user.id).profile.j_user_id
            if password == @current_user.password
                include ApiAuthenticable 
                user = @current_user               
                render json: { 
                message: 'Login successful', 
                user: { 
                    email: user.email,
                    profile_id: profile_id, 
                    access_token: @new_access_token, 
                    refresh_token: @new_refresh_token
                }
            },  status: :ok

            else
                render json: { error: 'Invalid password' }, status: :unauthorized
            end
        else
            render json: { error: 'User not found' }, status: :not_found
        end
    end
    def destroy
        if @current_user
            @current_user = nil
            render json: { message: 'Logout successful' }, status: :ok
        else
            render json: { error: 'No user logged in' }, status: :unauthorized
        end
    end     

end
