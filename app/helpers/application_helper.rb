module ApplicationHelper

  def nav_link
    render :partial => "shared/navi_link", :locals => {}
  end

  def languages
    Halloped::languages
  end

  def formatted_term_of(member)
    term = formatted_date member.term_start, end_date: member.term_end
    term = t 'organs.member.open_ended' if term.blank?
    term
  end

  def formatted_date(date, options={})
    [date, options[:end_date]].reject{ |date|
      date.blank? and options[:end_date].nil?
    }.map{ |date|
      format_date date, options
    }.join(' - ')
  end

  protected

  def format_date(date, options)
    if date.nil?
        ''
    else
      I18n.l(date, format: options[:format])
    end
  end
end
