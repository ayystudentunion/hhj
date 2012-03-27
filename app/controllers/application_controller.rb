class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  before_filter :set_university
  before_filter :init_organ

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def set_university
    @university = Organization.root || Factory.build(:organization)
  end

  def init_organ
    # TODO: figure out a better place to initialize empty objects for modals
    @organ = Factory.build(:organ)
  end

end
