require 'factory_girl_rails'

class PagesController < ApplicationController
  def logout
    for c in cookies
      cookies.delete c[0]
    end

    redirect_to index_path(locale: I18n.default_locale)
  end

  def university
    respond_to do |format|
      format.html { render "pages/_university" }
      format.fragment { render "pages/_university", formats: ['html'], layout: false }
    end
  end

  def default_locale_redirect
    redirect_to index_path(locale: I18n.default_locale)
  end

  def index
    @universities = Organization.roots.asc(:name)
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
    redirect_to(params[:target] || "/")
  end

  def dev_logout
    session[:test_user] = nil
    redirect_to "/"
  end

  def dev_users
    @users = [ {
      name: "teija",
      role: "union employee",
      desc: "Helsingin Yliopisto"
    }, {
      name: "aapo",
      role: "university staff",
      desc: "Helsingin Yliopisto"
    }, {
      name: "maltti",
      role: "student",
      desc: "Helsingin Yliopisto"
    }, {
      name: "anna",
      role: "union employee",
      desc: "Aalto-yliopisto"
    }, {
        name: "stu",
        role: "student",
        desc: "Aalto-yliopisto"
    }, {
      name: "reima",
      role: "student",
      desc: "from unknown university"

    } ]
    render :dev_users, layout: false
  end

end
