class PositionApplicationsController < ApplicationController
  # GET /position_applications
  # GET /position_applications.json
  def index
    @position_applications = PositionApplication.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @position_applications }
    end
  end

  # GET /position_applications/1
  # GET /position_applications/1.json
  def show
    @position_application = PositionApplication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @position_application }
    end
  end

  # GET /position_applications/new
  # GET /position_applications/new.json
  def new
    @position_application = PositionApplication.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @position_application }
    end
  end

  # GET /position_applications/1/edit
  def edit
    @position_application = PositionApplication.find(params[:id])
  end

  # POST /position_applications
  # POST /position_applications.json
  def create
    @position_application = PositionApplication.new(params[:position_application])

    respond_to do |format|
      if @position_application.save
        format.html { redirect_to @position_application, notice: 'Position application was successfully created.' }
        format.json { render json: @position_application, status: :created, location: @position_application }
      else
        format.html { render action: "new" }
        format.json { render json: @position_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /position_applications/1
  # PUT /position_applications/1.json
  def update
    @position_application = PositionApplication.find(params[:id])

    respond_to do |format|
      if @position_application.update_attributes(params[:position_application])
        format.html { redirect_to @position_application, notice: 'Position application was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @position_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /position_applications/1
  # DELETE /position_applications/1.json
  def destroy
    @position_application = PositionApplication.find(params[:id])
    @position_application.destroy

    respond_to do |format|
      format.html { redirect_to position_applications_url }
      format.json { head :no_content }
    end
  end
end
