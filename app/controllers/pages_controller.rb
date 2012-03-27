require 'factory_girl_rails'

class PagesController < ApplicationController

  def index
    respond_to do |format|
      format.html { render "pages/_frontpage" }
      format.fragment { render "pages/_frontpage", formats: ['html'], layout: false }
    end
  end

  def locale_redirect
    redirect_to "/fi"
  end

end
