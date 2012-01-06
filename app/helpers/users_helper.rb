module UsersHelper
  def user_avatar  
    image_tag("100X100.gif", :alt => "User Avatar Goes Here", 
              :class => "avatar", :height => "75", :width => "75")
  end
end
