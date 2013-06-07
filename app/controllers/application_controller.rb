# -*- encoding : utf-8 -*-
require 'factory_girl_rails'

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
  helper_method :can_admin_calls?
  helper_method :can_admin_organs?
  helper_method :can_apply?
  helper_method :not_supported_user

  layout :layout_by_context

  protected

  def user_role?(role)
    return false if not @user
    return false unless is_in_current_university?
    @user.role == role
  end

  def is_in_current_university?
    return false if not @user
    @user.university.key == @university.key
  end

  def can_admin_organs?
    user_role?(:role_university_staff) || user_role?(:role_union_employee)
  end

  def can_admin_calls?
    user_role?(:role_union_employee)
  end

  def can_apply?
    is_in_current_university?
  end

  def authorize_organ_admin
    if not can_admin_organs?
      render text: "Unauthorized", status: :unauthorized
      return false
    end
  end

  def authorize_call_admin
    if not can_admin_calls?
      render text: "Unauthorized", status: :unauthorized
      return false
    end
  end

  def authorize_applicant
    if not can_apply?
      render text: "Unauthorized", status: :unauthorized
      return false
    end
  end

  def not_supported_user
    return nil if @user
    User.env_to_attributes(request.env).select{|k,v| [:first_name, :last_name, :university_domain].include? k}
  end

  # In order to run and test authentication in development
  # environment. Add fake Shibboleth variables to request env
  def set_fake_env_for_development
    return unless session.include? :test_user
    test_user = session[:test_user]

    if Rails.env.test?
      attributes = FactoryGirl.attributes_for test_user
      request.env["A_PRINCIPAL_NAME"] = attributes[:principal_name]
      request.env["A_GIVEN_NAME"] = attributes[:first_name]
      request.env["A_SURNAME"] = attributes[:last_name]
      request.env["A_MOBILE"] = attributes[:phone]
      request.env["A_MAIL"] = attributes[:email]
      request.env["A_HOME_ORGANIZATION"] = attributes[:principal_name].split('@')[1]
    elsif Rails.env.development?
      test_user = session[:test_user]
      role = nil
      if test_user == "teija"
        request.env["A_PRINCIPAL_NAME"] = "teizit@helsinki.fi"
        request.env["A_GIVEN_NAME"] = "Teija"
        request.env["A_SURNAME"] = "Zitting"
        request.env["A_MOBILE"] = "+358 40 123 1234"
        request.env["A_MAIL"] = "teija.zitting@helsinki.fi"
        request.env["A_HOME_ORGANIZATION"] = "helsinki.fi"
        role = :role_union_employee
      elsif test_user == "aapo"
        request.env["A_PRINCIPAL_NAME"] = "aapoha@helsinki.fi"
        request.env["A_GIVEN_NAME"] = "Aapo"
        request.env["A_SURNAME"] = "Häkkinen"
        request.env["A_MOBILE"] = "+358 40 123 1234"
        request.env["A_MAIL"] = "aapo.hakkinen@helsinki.fi"
        request.env["A_HOME_ORGANIZATION"] = "helsinki.fi"
        role = :role_university_staff
      elsif test_user == "maltti"
        request.env["A_PRINCIPAL_NAME"] = 'malpul@helsinki.fi'
        request.env["A_GIVEN_NAME"] = "Maltti"
        request.env["A_SURNAME"] = "Pulliainen"
        request.env["A_MOBILE"] = "+358 40 555 4321"
        request.env["A_MAIL"] = "maltti@helsinki.fi"
        request.env["A_HOME_ORGANIZATION"] = "helsinki.fi"
        role = :role_student
      elsif test_user == "anna"
        request.env["A_PRINCIPAL_NAME"] = 'anna@aalto.fi'
        request.env["A_GIVEN_NAME"] = "Anna"
        request.env["A_SURNAME"] = "Kukka"
        request.env["A_MOBILE"] = "+358 40 555 7777"
        request.env["A_MAIL"] = "annakukka@aalto.fi"
        request.env["A_HOME_ORGANIZATION"] = "aalto.fi"
        role = :role_union_employee
      elsif test_user == "reima"
        request.env["A_PRINCIPAL_NAME"] = 'reima@xx.fi'
        request.env["A_GIVEN_NAME"] = "Reima"
        request.env["A_SURNAME"] = "Rento"
        request.env["A_MOBILE"] = "+358 40 555 8888"
        request.env["A_MAIL"] = "reima@xx.fi"
        request.env["A_HOME_ORGANIZATION"] = "xx.fi"
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

  def change_language(to_locale=nil)
    to_locale ||= request.query_parameters[:locale]
    return if to_locale.nil?
    return if request.fullpath =~ /\/admin\//
    current_path = Rails.application.routes.recognize_path request.fullpath
    redirect_to current_path.merge(locale: to_locale)
  end

  def set_locale
    locale = params[:locale]
    return if locale.nil?
    change_language(I18n.default_locale) unless Halloped::languages.include?(locale.to_sym)
    I18n.locale = locale
  end

  def set_university
    return if params[:university].nil?
    @university = Organization.roots.where(key: params[:university]).first
    redirect_to(index_path(locale: params[:locale])) if @university.nil?
  end

  def set_fixed_locale_for_admin_login
    I18n.locale = :en if request.fullpath.match /^\/admins\//
  end

  def layout_by_context
    if request.fullpath.match /^\/admins\//
      'device'
    else
      'application'
    end
  end

  def verify_university(organization)
    if @university.key != organization.root.key
      render_404
    end
  end

  def find_organ_from_current_university(symbol=:id)
    @organ = Organ.find(params[symbol])
    verify_university @organ.organization
    @organ
  end

  def find_call_from_current_university(symbol=:id)
    @call = Call.find(params[symbol])
    verify_university @call.organ.organization
    @call
  end

  def render_404
    respond_to do |format|
      format.html { render file: Rails.root.join('public/404.html'), status: :not_found , layout: false}
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
    position_application.user._id != @user._id && position_application.user.university == @user.university
  end

  helper_method :recommendation_allowed_for?
end
