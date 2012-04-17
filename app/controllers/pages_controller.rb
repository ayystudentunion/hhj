require 'factory_girl_rails'

class PagesController < ApplicationController

  def university
    respond_to do |format|
      format.html { render "pages/_frontpage" }
      format.fragment { render "pages/_frontpage", formats: ['html'], layout: false }
    end
  end

  def default_locale_redirect
    redirect_to index_path(locale: I18n.default_locale)
  end

  def index
    redirect_to university_path(locale: params[:locale], university: Organization.root.key)
  end

  def env
    @environment = request.env
    render "env", layout: false
  end

end
