require 'factory_girl_rails'

class ApplicationsController < ApplicationController

  def index
  end

  def new
    respond_to do |format|
      format.fragment
    end
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
