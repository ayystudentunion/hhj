require 'factory_girl_rails'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user
  before_filter :set_locale
  before_filter :set_university

  protected

  def set_locale
    locale = params[:locale] || I18n.default_locale
    redirect_to('/', locale: I18n.default_locale) unless Halloped::languages.include?(locale.to_sym)
    I18n.locale = locale
  end

  def set_university
    @university = Organization.root || FactoryGirl.build(:organization)
  end

  def set_user
    @user = FactoryGirl.create(:eija)
  end

end
