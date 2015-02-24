require 'spec_helper'

describe RecommendationsController do
  let(:recommendation) {
    # owned by eija
    FactoryGirl.create :recommendation
  }

  describe 'as tiina' do
    login_user :student_tiina

    it 'should only allow destroying own recommendations' do
      rid = recommendation.id
      expect do
        expect do
          post :destroy, id: rid, format: :js
        end.to raise_exception(Mongoid::Errors::DocumentNotFound)
      end.to_not change(Recommendation, :count)
    end
  end

  describe 'as eija' do
    login_user :eija

    it 'should allow destroy' do
      post :destroy, id: recommendation.id, format: :js
      response.should be_success
      Recommendation.count.should == 0
    end
  end
end
