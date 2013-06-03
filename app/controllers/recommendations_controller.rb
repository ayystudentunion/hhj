class RecommendationsController < ApplicationController
  respond_to :html, :js

  def create
    @position_application = PositionApplication.find(params[:position_application_id])
    @position_application.recommendations.create!(user_id: @user._id) unless @position_application.user._id == @user._id
    respond_to do |format|
      format.html { redirect_to call_path(id: @position_application.call._id) }
      format.js { render "refresh_recommend_link" }
    end
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])
    @position_application = @recommendation.position_application
    @recommendation.destroy
    respond_to do |format|
      format.html { redirect_to call_path(id: @position_application.call._id) }
      format.js { render "refresh_recommend_link" }
    end
  end
end
