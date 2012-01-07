module UsersHelper
  def user_avatar  
    if @user.avatar.exists?
      image_tag(@user.avatar(:thumb), :class => "avatar")
    else
      image_tag("100X100.gif", :class => "avatar", :height => "75", 
                :width => "75")
    end
  end
end
