class CallsController < ApplicationController

  def index
  end

  def new
    @organ = Organ.find params[:organ_id]
    @call  = CallForApplications.new
    respond_to do |format|
      format.fragment { render partial: "modals/call-for-application.html", locals: {organ: @organ, call: @call} }
    end
  end

end
