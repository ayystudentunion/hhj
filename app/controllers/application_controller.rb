class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  before_filter :set_university

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_university
    @university = Organization.root
  end

end
