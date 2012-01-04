module ApplicationHelper
  # Returns a title based on the page
  def title
    base_title = "Tutorial App"
    if @title.nil?
      base_title
    else 
      "#{base_title} | #{@title}"
    end
  end
  
  #returns the logo image tag
  def logo
    logo = image_tag("logo.png", :alt => "Tutorial App Yay!", :class => "round",
                     :height => "75", :width => "250")
  end
end
