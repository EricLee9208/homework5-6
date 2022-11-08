class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show]
  before_action :password_user, only: [:password]
  before_action :authorize_user!, only: [:edit, :update, :password]
  def new
    if user_signed_in?
      redirect_to root_path
    else
    @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash.notice = "Signed up!"
      redirect_to root_path
    else
      render :new, status: 303
    end
  end


  def edit
    
  end

  def password

  end

  def update
  @user = User.find_by_id session[:user_id]
   @current_password = params[:user][:current_password]
   @new_password  = params[:user][:password]
   @password_confirmation  = params[:user][:password_confirmation]
   puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
   puts @current_password
   puts @new_password
   puts @new_password_confirmation

   
   if @current_password 
    
      if @user && @user.authenticate(@current_password)
          if @new_password == @password_confirmation 
            if @new_password != @current_password
              @user.update params.require(:user).permit(
                :password
               )
               flash[:success] = "User successfully updated"
               redirect_to root_path
            else
              render :password, {alert: "Please eneter new Password", status: 303}
            end
         
          else
            flash[:alert] = "New password does not match New Password confirmation"
            render :password, {alert: "New password does not match New Password confirmation", status: 303}
          end
      else
        flash[:alert] = "Wrong Current Password"
        render :password, {alert: "Wrong Password", status: 303}
      end
  else
    if @user.update params.require(:user).permit(
      :first_name,
      :last_name,
      :email
    )
      flash[:success] = "User successfully updated"
      redirect_to root_path
    else
      render :edit, status: 303
    end
  end
end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def find_user
    @user = User.find params[:id]
  end
  def password_user
    @user = User.find params[:user_id]
  end

  def authorize_user!
    redirect_to root_path, alert: "Not authorized" unless can?(:crud, @user)
    
  end
end
