module ApplicationHelper

  def nav_link
    render :partial => "shared/navi_link", :locals => {}
  end

  def languages
    I18n.fallbacks.keys.concat(I18n.available_locales).uniq
  end

end
