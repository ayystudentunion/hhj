
require "cgi"

module ApplicationHelper

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

  def login_link
    current = request.fullpath
    if Rails.env.development?
      #dev_login_path(target: current)
      dev_users_path(target: current)
    else
      "/Shibboleth.sso/Login?target=#{CGI.escape current}"
    end
  end

  def logout_link
    if Rails.env.development?
      dev_logout_path
    end
  end

  def relative_custom_path()
    Pathname.new @university.key
  end

  def custom_template(name)
    relative_custom_path.join(name).to_s
  end

  def custom_template_exists?(name)
    lookup_context.find_all(relative_custom_path.join("_#{name}.html")).any?
  end

  def custom_css_exists?()
    return false if @university.nil?
    Rails.root.join(custom_css('public')).exist?
  end

  def custom_css(prefix='/')
    Pathname.new(prefix).join 'universities', relative_custom_path, "#{@university.key}.css"
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
