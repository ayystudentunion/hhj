module ControllerMacros
  def login_user(user)
    before :each do
      session[:test_user] = user
    end
  end

  def login_admin
    before :each do
      session[:test_user] = FactoryGirl.create :helsinki_uni_student_union_employee
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
end
