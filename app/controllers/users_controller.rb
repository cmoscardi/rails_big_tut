class UsersController < ApplicationController
  def new
    @title = "Sign up"
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create 
    @user = User.new(params[:user])
    if @user.save
      redirect_to signin_path
      flash[:success] = "Welcome to the Sample App! Log in now to view your profile"
    else 
      @title = "Sign up"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end
  end
end
