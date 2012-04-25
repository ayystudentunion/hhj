require 'factory_girl_rails'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_fake_env_for_development
  before_filter :set_user
  before_filter :change_language
  before_filter :set_locale
  before_filter :set_university
  before_filter :set_fixed_locale_for_admin_login

  layout :layout_by_context

  protected

  def set_fake_env_for_development
    # In order to run and test authentication in development
    # environment. Add fake Shibboleth variables to request env
    if Rails.env.development?
      request.env["A_PRINCIPAL_NAME"] = "eizit@ayy.fi"
      request.env["A_GIVEN_NAME"] = "Eija"
      request.env["A_SURNAME"] = "Zitting"
      request.env["A_MOBILE"] = "+358 40 123 1234"
      request.env["A_MAIL"] = "eija.zitting@ayy.fi"
    end
  end

  def set_user
    @user = User.update_or_create_from_env(request.env) # FactoryGirl.create(:eija)
  end

  def change_language(to_locale=nil)
    to_locale ||= request.query_parameters[:locale]
    return if to_locale.nil?
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

end
