module Sanitizer
  def self.sanitize_filename(filename)
    filename.strip.gsub(/[^0-9A-Za-z.\-]/, '_')
  end
end
