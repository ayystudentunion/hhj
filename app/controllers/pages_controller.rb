class PagesController < ApplicationController

  def index
  end

  def locale_redirect
    redirect_to "/fi"
  end

end
