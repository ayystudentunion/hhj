module ApplicationHelper

  def nav_link
    render :partial => "shared/navi_link", :locals => {}
  end

  def languages
    Halloped::languages
  end

  def formatted_date(date, end_date=nil)
    [date, end_date].reject(&:blank?).map{|date| I18n.l date}.join(' - ')
  end

end
