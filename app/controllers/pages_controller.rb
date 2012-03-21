class PagesController < ApplicationController

  def index
    render :index, :layout => false
  end

  def locale_redirect
    redirect_to "/fi"
  end

end
