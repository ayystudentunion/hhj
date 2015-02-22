module PhoneNumberChecker

  def self.is_ok?(number)
     number.present? && number.length > 4
  end
end
