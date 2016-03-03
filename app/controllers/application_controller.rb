# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_fake_env_for_development
  before_filter :set_user
  before_filter :change_language
  before_filter :set_locale
  before_filter :set_university
  before_filter :set_fixed_locale_for_admin_login
  before_filter :init_custom_view_paths

  helper_method :user_role?
  helper_method :is_in_current_university?
  helper_method :student_union_employee?
  helper_method :can_admin_organs?
  helper_method :can_apply?
  helper_method :not_supported_user

  layout :layout_by_context

  protected

  def user_role?(role)
    return false unless @user
    return false unless is_in_current_university?
    @user.role == role
  end

  def is_in_current_university?
    return false unless @user
    @user.university.key == @university.key
  end

  def can_admin_organs?
    user_role?(:role_university_staff) || user_role?(:role_union_employee)
  end

  def student_union_employee?
    user_role?(:role_union_employee)
  end

  def can_apply?
    is_in_current_university?
  end

  def authorize_organ_admin
    unless can_admin_organs?
      render plain: 'Unauthorized', status: :unauthorized
      return false
    end
  end

  def authorize_call_admin
    unless student_union_employee?
      render plain: 'Unauthorized', status: :unauthorized
      return false
    end
  end

  def authorize_applicant
    unless can_apply?
      render plain: 'Unauthorized', status: :unauthorized
      return false
    end
  end

  def not_supported_user
    return nil if @user
    User.env_to_attributes(request.env).select { |k, _v| [:first_name, :last_name, :university_domain].include? k }
  end

  # In order to run and test authentication in development
  # environment. Add fake Shibboleth variables to request env
  def set_fake_env_for_development
    return unless session.include? :test_user
    test_user = session[:test_user]

    if Rails.env.test?
      attributes = FactoryGirl.attributes_for test_user
      request.env['A_PRINCIPAL_NAME'] = attributes[:principal_name]
      request.env['A_GIVEN_NAME'] = attributes[:first_name]
      request.env['A_SURNAME'] = attributes[:last_name]
      request.env['A_MOBILE'] = attributes[:phone]
      request.env['A_MAIL'] = attributes[:email]
      request.env['A_HOME_ORGANIZATION'] = attributes[:principal_name].split('@')[1]
    elsif Rails.env.development? || Rails.env.heroku?
      test_user = session[:test_user]
      role = nil
      if test_user == 'teija'
        request.env['A_PRINCIPAL_NAME'] = 'teizit@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Teija'
        request.env['A_SURNAME'] = 'Zitting'
        request.env['A_MOBILE'] = '+358 40 123 1234'
        request.env['A_MAIL'] = 'teija.zitting@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_union_employee
      elsif test_user == 'aapo'
        request.env['A_PRINCIPAL_NAME'] = 'aapoha@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Aapo'
        request.env['A_SURNAME'] = "Häkkinen"
        request.env['A_MOBILE'] = '+358 40 123 1234'
        request.env['A_MAIL'] = 'aapo.hakkinen@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_university_staff
      elsif test_user == 'maltti'
        request.env['A_PRINCIPAL_NAME'] = 'malpul@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Maltti'
        request.env['A_SURNAME'] = 'Pulliainen'
        request.env['A_MOBILE'] = '+358 40 555 4321'
        request.env['A_MAIL'] = 'maltti@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'tiina'
        request.env['A_PRINCIPAL_NAME'] = 'tiina.kumpulainen@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Tiina'
        request.env['A_SURNAME'] = 'Kumpulainen'
        request.env['A_MOBILE'] = '+358 40 555 900'
        request.env['A_MAIL'] = 'tiina.kumpulainen@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'liisa'
        request.env['A_PRINCIPAL_NAME'] = 'liisa.mattila@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Liisa'
        request.env['A_SURNAME'] = 'Mattila'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'liisa.mattila@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'no_phone_student'
        request.env['A_PRINCIPAL_NAME'] = 'nophone@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'No'
        request.env['A_SURNAME'] = 'Phone'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'nophone@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'anna'
        request.env['A_PRINCIPAL_NAME'] = 'anna@aalto.fi'
        request.env['A_GIVEN_NAME'] = 'Anna'
        request.env['A_SURNAME'] = 'Kukka'
        request.env['A_MOBILE'] = '+358 40 555 7777'
        request.env['A_MAIL'] = 'annakukka@aalto.fi'
        request.env['A_HOME_ORGANIZATION'] = 'aalto.fi'
        role = :role_union_employee
      elsif test_user == 'stu'
        request.env['A_PRINCIPAL_NAME'] = 'stu.dent@aalto.fi'
        request.env['A_GIVEN_NAME'] = 'Stu '
        request.env['A_SURNAME'] = 'Dent'
        request.env['A_MOBILE'] = '0'
        request.env['A_MAIL'] = 'stu.dent@aalto.fi'
        request.env['A_HOME_ORGANIZATION'] = 'aalto.fi'
        role = :role_student
      elsif test_user == 'reima'
        request.env['A_PRINCIPAL_NAME'] = 'reima@xx.fi'
        request.env['A_GIVEN_NAME'] = 'Reima'
        request.env['A_SURNAME'] = 'Rento'
        request.env['A_MOBILE'] = '+358 40 555 8888'
        request.env['A_MAIL'] = 'reima@xx.fi'
        request.env['A_HOME_ORGANIZATION'] = 'xx.fi'
        role = :role_student
      elsif test_user == 'laura'
        request.env['A_PRINCIPAL_NAME'] = 'laura.mattila@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Laura'
        request.env['A_SURNAME'] = 'Mattila'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'laura.mattila@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'raisa'
        request.env['A_PRINCIPAL_NAME'] = 'raisa.kiimamaa@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Raisa'
        request.env['A_SURNAME'] = 'Kiimamaa'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'raisa.kiimamaa@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'jaakko'
        request.env['A_PRINCIPAL_NAME'] = 'jaakko.teppo@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Jaakko'
        request.env['A_SURNAME'] = 'Teppo'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'jaakko.teppo@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'harri'
        request.env['A_PRINCIPAL_NAME'] = 'harri.macklin@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Harri'
        request.env['A_SURNAME'] = "Mäcklin"
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'harri.macklin@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'sanna'
        request.env['A_PRINCIPAL_NAME'] = 'sanna.liesto@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Sanna'
        request.env['A_SURNAME'] = 'Liesto'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'sanna.liesto@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'natalia'
        request.env['A_PRINCIPAL_NAME'] = 'natalia.bogdan@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Natalia'
        request.env['A_SURNAME'] = 'Bogdan'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'natalia.bogdan@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'emma'
        request.env['A_PRINCIPAL_NAME'] = 'emma.kuntze@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Emma'
        request.env['A_SURNAME'] = 'Kuntze'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'emma.kuntze@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'janne'
        request.env['A_PRINCIPAL_NAME'] = 'janne.lardot@hyy.fi'
        request.env['A_GIVEN_NAME'] = 'Janne'
        request.env['A_SURNAME'] = 'Lardot'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'janne.lardot@hyy.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_union_employee
      elsif test_user == 'tommi'
        request.env['A_PRINCIPAL_NAME'] = 'tommi.jalo@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Tommi'
        request.env['A_SURNAME'] = 'Jalo'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'tommi.jalo@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'anton'
        request.env['A_PRINCIPAL_NAME'] = 'anton.saressalo@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Anton'
        request.env['A_SURNAME'] = 'Saressalo'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'anton.saressalo@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'katariina'
        request.env['A_PRINCIPAL_NAME'] = 'katariina.jarvi@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Katariina'
        request.env['A_SURNAME'] = "Järvi"
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'katariina.jarvi@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'sanni'
        request.env['A_PRINCIPAL_NAME'] = 'sanni.suhonen@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Sanni'
        request.env['A_SURNAME'] = 'Suhonen'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'sanni.suhonen@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'anni'
        request.env['A_PRINCIPAL_NAME'] = 'anni.nelimarkka@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Anni'
        request.env['A_SURNAME'] = 'Nelimarkka'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'anni.nelimarkka@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'salla'
        request.env['A_PRINCIPAL_NAME'] = 'salla.huttunen@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Salla'
        request.env['A_SURNAME'] = 'Huttunen'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'salla.huttunen@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'josi'
        request.env['A_PRINCIPAL_NAME'] = 'josi.seilonen@helsinki.fi'
        request.env['A_GIVEN_NAME'] = 'Josi'
        request.env['A_SURNAME'] = 'Seilonen'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'josi1.seilonen@helsinki.fi;josi2.seilonen@helsinki.fi'
        request.env['A_HOME_ORGANIZATION'] = 'helsinki.fi'
        role = :role_student
      elsif test_user == 'hilda'
        request.env['A_PRINCIPAL_NAME'] = 'hilda.svanson@isyy.fi'
        request.env['A_GIVEN_NAME'] = 'Hilda'
        request.env['A_SURNAME'] = 'Svanson'
        request.env['A_MOBILE'] = ''
        request.env['A_MAIL'] = 'hilda.svanson@isyy.fi'
        request.env['A_HOME_ORGANIZATION'] = 'uef.fi'
        role = :role_student
      end
      if role
        user = User.update_or_create_from_env(request.env)
        user.update_attributes!(role: role) if user
      end

    end
  end

  def set_user
    @user = User.update_or_create_from_env(request.env)
  end

  def change_language(to_locale = nil)
    to_locale ||= request.query_parameters[:locale]
    return if to_locale.nil?
    return if request.fullpath =~ /\/admin\//
    current_path = Rails.application.routes.recognize_path request.fullpath
    redirect_to current_path.merge(locale: to_locale)
  end

  def set_locale
    locale = params[:locale]
    return if locale.nil?
    change_language(I18n.default_locale) unless Halloped.languages.include?(locale.to_sym)
    I18n.locale = locale
  end

  def set_university
    return if params[:university].nil?
    @university = Organization.roots.where(key: params[:university]).first
    redirect_to(index_path(locale: params[:locale])) if @university.nil?
  end

  def set_fixed_locale_for_admin_login
    I18n.locale = :en if request.fullpath =~ /^\/admins\//
  end

  def layout_by_context
    if request.fullpath =~ /^\/admins\//
      'devise'
    else
      'application'
    end
  end

  def verify_university(organization)
    render_404 if @university.key != organization.root.key
  end

  def find_organ_from_current_university(symbol = :id)
    @organ = Organ.find(params[symbol])
    verify_university @organ.organization
    @organ
  end

  def find_call_from_current_university(symbol = :id)
    @call = Call.find(params[symbol])
    verify_university @call.organ.organization
    @call
  end

  def render_404
    respond_to do |format|
      format.html { render file: Rails.root.join('public/404.html'), status: :not_found, layout: false }
      format.any  { head :not_found }
    end
  end

  def init_custom_view_paths
    return unless @university
    @custom_root = Rails.root.join('public/universities')
    @custom_path = @custom_root.join(@university.key)
    prepend_view_path @custom_path
    prepend_view_path @custom_root
  end

  def recommendation_allowed_for?(position_application)
    position_application.user._id != @user._id &&
      position_application.user.university == @user.university &&
      position_application.applying_for_member? && position_application.deputy.present? &&
      position_application.deputy.user._id != @user._id
  end

  helper_method :recommendation_allowed_for?
end
