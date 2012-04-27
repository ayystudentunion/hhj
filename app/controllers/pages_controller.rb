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
    @universities = Organization.roots
    respond_to do |format|
      format.html { render "pages/index", layout: 'index' }
      format.fragment { render "pages/index", formats: ['html'], layout: false }
    end
  end

  def environment
    @environment = request.env
    render "env", layout: false
  end

  def dev_login
    session[:test_user] = params[:user] || "eija"
    redirect_to params[:target]
  end

  def dev_logout
    session[:test_user] = nil
    redirect_to "/"
  end

  def dev_users
    @users = ["eija"]
    render :dev_users, layout: false
  end

end
