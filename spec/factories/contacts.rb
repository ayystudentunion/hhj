FactoryGirl.define do

  factory :contact do
    name 'Mr Contactabull'
    email 'halloped_contact@hyy.fi'
    phone_number '+358 40 555 8899'
    university { TestSingletons.sparta }
  end
end
