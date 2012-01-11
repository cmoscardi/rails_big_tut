module SessionsHelper
  def sign_in(user)
    session[:user_id]= user.id
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def sign_out
    session[:user_id]=nil
    self.current_user=nil
  end

  def signed_in?
    !current_user.nil?
  end

  private
  
    def user_from_remember_token
      return User.find_by_id(session[:user_id])
    end


    
end
