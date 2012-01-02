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
end
