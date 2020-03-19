class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:edit, :update, :change_password]
    before_action :find_user, only: [:edit, :update, :change_password, :update_password]
    
    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        
    end
    
    def update
        if authorize?
            flash[:alert] = "Cannot update other user"
            redirect_to root_path
        else
            if @user.update user_params
                flash[:notice] = 'user updated Successfully'
                redirect_to root_path
            else
                render :edit
            end
        end
        
    end
    
    def change_password
    end
    
    def update_password
        if @user&.authenticate params[:current_password]  
            if params[:new_password] == params[:new_password_confirmation] 
                params[:password] = params[:new_password] 
                if @user.update params.permit(:password)
                    flash[:success] = "Password changed"
                    redirect_to root_path
                end
            else
                flash[:alert] = "New password have to match"
                render :change_password
            end
        else
            flash[:alert] = "Current password has to be matched"
            render :change_password
        end
    end
    
    private
    
    def find_user
        @user=User.find params[:id]
    end

    def user_params
        params.require(:user).permit(:first_name,
         :last_name, :email, :password, :password_confirmation)
    end

    def authorize?
        @user != current_user
    end
end
