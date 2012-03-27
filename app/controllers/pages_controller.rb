require 'factory_girl_rails'

class PagesController < ApplicationController

  def index
    @organ = Factory.build(:organ)

    render "pages/_frontpage"
  end

  def locale_redirect
    redirect_to "/fi"
  end

end
