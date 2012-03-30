module ApplicationHelper

  def nav_link
    render :partial => "shared/navi_link", :locals => {}
  end

  def languages
    Halloped::languages
  end

  def formatted_date(date, options={})
    [date, options[:end_date]].reject(&:blank?).map{|date| I18n.l(date, format: options[:format])}.join(' - ')
  end

end
