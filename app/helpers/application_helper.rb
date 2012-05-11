
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

  def custom_file(name)
    Pathname.new(@university.key).join(name).to_s
  end

  def custom_file_exists?(name)
    lookup_context.find_all(custom_file(name)).any?
  end

  def custom_template_exists?(name)
    custom_file_exists?("_#{name}.html")
  end

  def custom_css_file_name
    "#{@university.key}.css"
  end

  def custom_css_file_path
    @custom_path.join custom_css_file_name
  end

  def custom_css_exists?
    return false if @university.nil?
    custom_file_exists?(custom_css_file_name)
  end

  def custom_css_href
    @custom_public_path.join custom_css_file_name
  end

  def user_university_not_supported?
    not_supported_user and not not_supported_user[:university_domain].blank?
  end

  def not_supported_user_full_name
    [not_supported_user[:first_name], not_supported_user[:last_name]].reject(&:blank?).join(' ')
  end

  def not_supported_user_university_domain
    not_supported_user[:university_domain]
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
