require 'factory_girl_rails'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user
  before_filter :set_locale
  before_filter :set_university

  protected

  def set_user
    @user = FactoryGirl.create(:eija)
  end

  def set_locale
    return if params[:locale].nil?
    locale = params[:locale]
    redirect_to(root_path) unless Halloped::languages.include?(locale.to_sym)
    I18n.locale = locale
  end

  def set_university
    return if params[:university].nil?
    @university = Organization.roots.where(key: params[:university]).first
    redirect_to(index_path(locale: params[:locale])) if @university.nil?
  end

end
