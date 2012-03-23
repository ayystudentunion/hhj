module ApplicationHelper

  def nav_link
    render :partial => "shared/navi_link", :locals => {}
  end

end
