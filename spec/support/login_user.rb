module ControllerMacros
  def login_user(user)
    before :each do
      session[:test_user] = user
    end
  end
end

RSpec.configure do |config|
  config.extend ControllerMacros, :type => :controller
end
