if ENV['AIRBRAKE_API_KEY']
  Airbrake.configure do |config|
    config.api_key = ENV['AIRBRAKE_API_KEY']
  end
else
  path = Rails.root.join('config/airbrake.key')
  if File.exists? path
    Airbrake.configure do |config|
      config.api_key = File.read(path).strip
    end
  end
end
