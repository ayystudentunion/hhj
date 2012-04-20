require 'factory_girl_rails'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user
  before_filter :change_language
  before_filter :set_locale
  before_filter :set_university

  protected

  def set_user
    @user = FactoryGirl.create(:eija)
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
    locale = :en if request.fullpath.match(/^admin/)
    I18n.locale = locale

  end

  def set_university
    return if params[:university].nil?
    @university = Organization.roots.where(key: params[:university]).first
    redirect_to(index_path(locale: params[:locale])) if @university.nil?
  end

end
