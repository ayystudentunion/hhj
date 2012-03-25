class PagesController < ApplicationController

  def index
    @organ = Factory.build(:organ)
  end

  def locale_redirect
    redirect_to "/fi"
  end

end
