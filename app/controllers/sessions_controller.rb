class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                        params[:session][:password])
    if user
      sign_in user
      redirect_to user
    else 
      flash.now[:error]="There was an error while signing in!"
      @title = "Sign in"
      render 'new'
    end
  end

  def destroy
    sign_out
    flash[:success]= "You have successfully signed out"
    redirect_to root_path
  end

end
