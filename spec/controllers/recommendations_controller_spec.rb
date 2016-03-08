require 'spec_helper'

describe RecommendationsController do
  let(:recommendation) do
    # owned by eija
    FactoryGirl.create :recommendation
  end

  describe 'as tiina' do
    login_user :student_tiina

    it 'should only allow destroying own recommendations' do
      rid = recommendation.to_param
      expect do
        expect do
          post :destroy, id: rid, format: :js, locale: :fi, university: 'sty'
        end.to raise_exception(RuntimeError)
      end.to_not change(Recommendation, :count)
    end
  end

  describe 'as eija' do
    login_user :eija

    it 'should allow destroy' do
      post :destroy, id: recommendation.to_param, format: :js, locale: :fi, university: 'sty'
      response.should be_success
      Recommendation.count.should == 0
    end
  end
end
