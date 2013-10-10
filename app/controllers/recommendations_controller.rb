class RecommendationsController < ApplicationController
  respond_to :html, :js

  def create
    @position_application = PositionApplication.find(params[:position_application_id])
    @position_application.recommendations.create!(user_id: @user._id) if recommendation_allowed_for?(@position_application)
    respond_to do |format|
      format.html { redirect_to call_path(id: @position_application.call._id) }
      format.js { render "refresh_recommend_link" }
    end
  end

  def destroy
    @recommendation = @user.recommendations.find(params[:id])
    @position_application = @recommendation.position_application
    @recommendation.destroy
    respond_to do |format|
      format.js { render "refresh_recommend_link" }
    end
  end

end
